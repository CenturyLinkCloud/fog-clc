module Fog
  module Compute
    class CLC
      class Real
        def create_pool(dc, lb, port, method, persistence)
          request(
            :expects  => [200, 201, 202],
            :method   => "POST",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}/#{lb}/pools",
            :body     => Fog::JSON.encode(
                        {
                          :port => port,
                          :method => method,
                          :persistence => persistence,
                        }
                      )
          )
        end
      end

      class Mock
        def create_pool(dc, lb, port, method, persistence)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
