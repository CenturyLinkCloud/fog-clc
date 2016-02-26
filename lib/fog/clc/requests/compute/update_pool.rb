module Fog
  module Compute
    class CLC
      class Real
        def update_pool(dc, lb, id, method, persistence)
          request(
            :expects  => [204],
            :method   => "PUT",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}/#{lb}/pools/#{id}",
            :body     => Fog::JSON.encode(
                        {
                          :method => method,
                          :persistence => persistence,
                        }
                      )
          )
        end
      end

      class Mock
        def update_pool(dc, lb, id, method, persistence)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
