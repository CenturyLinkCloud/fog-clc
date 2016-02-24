module Fog
  module Compute
    class CLC
      class Real
        def create_lb(dc, name, desc='', status=nil)
          resp = request(
            :expects  => [200, 201, 202],
            :method   => "POST",
            :path     => "/v2/sharedLoadBalancers/#{clc_alias}/#{dc}",
            :body     => Fog::JSON.encode(
                        {
                          :name => name,
                          :description => desc,
                          :status => (status || 'enabled'),
                        }
                      )
            )
        end
      end

      class Mock
        def create_lb(dc)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
