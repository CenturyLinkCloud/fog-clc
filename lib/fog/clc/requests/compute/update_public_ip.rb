module Fog
  module Compute
    class CLC
      class Real
        def update_public_ip(id, ip, ports, restrictions)
          data = {
            :ports => ports,
            :sourceRestrictions => restrictions,
          }
          resp = request(
            :expects  => [200, 201, 202],
            :method   => "PUT",
            :path     => "/v2/servers/#{clc_alias}/#{id}/publicIPAddresses/#{ip}",
            :body     => Fog::JSON.encode(data)
          )
        end
      end

      class Mock
        def update_public_ip(attributes)
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
