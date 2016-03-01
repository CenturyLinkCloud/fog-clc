module Fog
  module Compute
    class CLC
      class Real
        def set_power_state(state, servers)
          raise ArgumentError, "allowable #{Fog::CLC::POWER_STATES.inspect}" unless Fog::CLC::POWER_STATES.include?(state.to_s)
          # returns array of status objects to poll
          request(
            :expects  => [200, 201, 202],
            :method   => "POST",
            :path     => "/v2/operations/#{clc_alias}/servers/#{state}",
            :body     => Fog::JSON.encode(servers),
          )
        end
      end

      class Mock
        def set_power_state(state, ids)
          Fog::Mock.not_implemented
          #response = Excon::Response.new
          #response.status = 200
          #response.body = {
          #}
          #response
        end
      end
    end
  end
end
