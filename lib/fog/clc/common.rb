
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
        if POLL_ASYNC && resp['isQueued']
          poll_status(resp, service)
        else
          resp
        end
      end

      def poll_status(resp, service)
        if st = links(resp)['status']
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
