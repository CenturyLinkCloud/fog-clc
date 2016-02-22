
module Fog
  module CLC

    module Common
      extend self
      def links(resp)
        Hash[resp['links'].collect {|l| [l['rel'], l['id']].compact }.compact]
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
        st ||= links(resp)['status']
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
  end
end
