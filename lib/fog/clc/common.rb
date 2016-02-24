module Fog
  module CLC
    module Common
      extend self

      # links are returned in this general form:
      # {
      #    "rel"=>"self",
      #    "href"=>"/v2/sharedLoadBalancers/pb/ca1/df22a758700f4610a3594876e2ae41f0/pools/587c72124b9a449ba2145dfcbaf6be66",
      #    "verbs"=>["GET", "PUT", "DELETE"]}
      # }
      # {
      #    "rel"=>"self",
      #    "id"=>"587c72124b9a449ba2145dfcbaf6be66",
      #    "href"=>"/v2/sharedLoadBalancers/pb/ca1/df22a758700f4610a3594876e2ae41f0/pools/587c72124b9a449ba2145dfcbaf6be66",
      # }


      def linkmap(links, attr='id')
        # given an array of links
        Hash[links.collect {|l| [l['rel'], l[attr]].compact }.compact]
      end

      def href
        linkmap(self.links, 'href')['self'] if respond_to?(:links)
      end

      def set_dc
        # /v2/<entity>/{accountAlias}/{dataCenter}/{id}
        self.dc = href.split('/')[4].upcase if respond_to?(:dc=)
      end

      def check_uuid(id)
        if id =~ /[0-9a-f]{32}/
          id + "?uuid=true"
        else
          id.upcase
        end
      end

      def block_status(&block)
        resp = yield
        if POLL_ASYNC
          poll_status(resp, service)
        else
          resp
        end
      end

      def poll_status(resp, service)
        # grr, we get one of the following from platform
        # {"links" => [...]}
        # {"status" => "<dc>-<id>" ... }
        # {"rel" => "status", "id" => "<dc>-<id>" ...}
        st = (resp["rel"] == "status") && resp["id"]
        st ||= resp["status"]
        st ||= linkmap(resp['links'])['status']
        if st
          loop do
            resp = service.get_status(st)
            Fog::Logger.debug "polling status #{st} ==> #{resp.inspect}"
            break if ['succeeded', 'failed'].include?(resp['status'])
            sleep(POLL_INTERVAL)
          end
          resp
        else
          raise Fog::CLC::Errors::ServiceError, "expected queued response but received: #{resp}"
        end
      end

    end


    module Errors
      class ServiceError < Fog::Errors::Error
        attr_reader :response_data, :status_code, :transaction_id

        def to_s
          status = status_code ? "HTTP #{status_code}" : "HTTP <Unknown>"
          "[#{status} | #{transaction_id}] #{super}"
        end

        def self.slurp(error, service=nil)
          data = nil
          message = nil
          status_code = nil

          if error.response
            status_code = error.response.status
            unless error.response.body.empty?
              begin
                data = Fog::JSON.decode(error.response.body)
                message = extract_message(data)
              rescue  => e
                Fog::Logger.warning("Received exception '#{e}' while decoding>> #{error.response.body}")
                message = error.response.body
                data = error.response.body
              end
            end
          end

          new_error = super(error, message)
          new_error.instance_variable_set(:@response_data, data)
          new_error.instance_variable_set(:@status_code, status_code)
          new_error.set_transaction_id(error, service)
          new_error
        end

        def set_transaction_id(error, service)
          return unless service && service.respond_to?(:request_id_header) && error.response
          @transaction_id = error.response.headers[service.request_id_header]
        end

        def self.extract_message(data)
          if data.is_a?(Hash)
            message = data.values.first['message'] if data.values.first.is_a?(Hash)
            message ||= data['message']
          end
          message || data.inspect
        end
      end

      class InternalServerError < ServiceError; end
      class Conflict < ServiceError; end
      class ServiceUnavailable < ServiceError; end
      class MethodNotAllowed < ServiceError; end
      class BadRequest < ServiceError
        attr_reader :validation_errors

        def to_s
          "#{super} - #{validation_errors}"
        end

        def self.slurp(error, service=nil)
          new_error = super(error)
          unless new_error.response_data.nil? or new_error.response_data['badRequest'].nil?
            new_error.instance_variable_set(:@validation_errors, new_error.response_data['badRequest']['validationErrors'])
          end

          status_code = error.response ? error.response.status : nil
          new_error.instance_variable_set(:@status_code, status_code)
          new_error.set_transaction_id(error, service)
          new_error
        end
      end
    end

  end
end
