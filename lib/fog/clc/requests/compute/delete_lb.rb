module Fog
  module Compute
    class CLC
      class Real
        def delete_lb(dc, id)
          resp = request(
            :expects  => [200, 201, 202],
            :method   => "DELETE",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}/#{id}"
          )
        end
      end

      class Mock
        def delete_lb(dc, id)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
