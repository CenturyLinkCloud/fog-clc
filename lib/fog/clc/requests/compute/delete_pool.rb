module Fog
  module Compute
    class CLC
      class Real
        def delete_pool(dc, lb, id)
          request(
            :expects  => [204],
            :method   => "DELETE",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}/#{lb}/pools/#{id}",
          )
        end
      end

      class Mock
        def delete_pool(dc, lb, id)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
