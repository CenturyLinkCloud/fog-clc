module Fog
  module Compute
    class CLC
      class Real
        def get_dc_capabilities(dc)
          resp = request(
            :expects  => [200],
            :method   => "GET",
            :path     => "/v2/datacenters/#{clc_alias}/#{dc}/deploymentCapabilities"
          )
        end
      end

      class Mock
        def get_dc_capabilities(dc)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
