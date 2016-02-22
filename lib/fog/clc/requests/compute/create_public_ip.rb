module Fog
  module Compute
    class CLC
      class Real
        def create_public_ip(id, ip, ports, restrictions)
          data = {}
          data[:internalIPAddress] = ip if ip
          data[:ports] = ports if (ports && !ports.empty?)
          data[:sourceRestrictions] = restrictions if \
            (restrictions && !restrictions.empty?)
          resp = request(
            :expects  => [200, 201, 202],
            :method   => "POST",
            :path     => "/v2/servers/#{clc_alias}/#{id}/publicIPAddresses",
            :body     => Fog::JSON.encode(data)
          )
        end
      end

      class Mock
        def add_public_ip(attributes)
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
