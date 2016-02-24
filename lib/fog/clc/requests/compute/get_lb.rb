module Fog
  module Compute
    class CLC
      class Real
        def get_lb(dc, id)
          resp = request(
            :expects  => [200],
            :method   => "GET",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}/#{id}"
          )
          resp["dc"] = dc
          resp
        end
      end

      class Mock
        def get_lb(dc, id)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
