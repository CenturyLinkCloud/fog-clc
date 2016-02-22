module Fog
  module Compute
    class CLC 
      class Real
        def get_public_ip(id, ip)
          resp = request(
            :expects  => [200, 201, 202],
            :method   => "GET",
            :path     => "/v2/servers/#{clc_alias}/#{id}/publicIPAddresses/#{ip}",
          )
        end
      end

      class Mock
        def get_public_ip(attributes)
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
