module Fog
  module Compute
    class CLC
      class Real
        def get_dc(dc)
          resp = request(
            :expects  => [200],
            :method   => "GET",
            :path     => "/v2/datacenters/#{clc_alias}/#{dc}?groupLinks=true"
          )
        end
      end

      class Mock
        def get_dc(dc, id)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
