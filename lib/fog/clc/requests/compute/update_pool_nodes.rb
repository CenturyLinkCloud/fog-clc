module Fog
  module Compute
    class CLC
      class Real
        def update_pool_nodes(dc, lb, pool, nodes=[])
          # [{ "ipAddress":"10.11.12.18", "privatePort":8080 }...]
          request(
            :expects  => [204],
            :method   => "PUT",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}/#{lb}/pools/#{pool}/nodes",
            :body     => Fog::JSON.encode(nodes)
          )
        end
      end

      class Mock
        def update_pool_nodes(dc, lb, pool, nodes)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
