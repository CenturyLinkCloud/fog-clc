module Fog
  module Compute
    class CLC
      class Real
        def get_pool(dc, lb, id)
          request(
            :expects  => [200],
            :method   => "GET",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}/#{lb}/pools/#{id}"
          )
        end
      end

      class Mock
        def get_pool(dc, lb, id)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
