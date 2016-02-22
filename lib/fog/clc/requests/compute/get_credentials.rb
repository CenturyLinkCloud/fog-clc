module Fog
  module Compute
    class CLC
      class Real
        def get_credentials(id)
          request(
            :expects  => [200],
            :method   => "GET",
            :path     => "/v2/servers/#{clc_alias}/#{id}/credentials"
          )
        end
      end

      class Mock
        def get_credentials
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
