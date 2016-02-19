module Fog
  module Compute
    class CLC
      class Real

        def list_groups
          request(
            :expects  => [200],
            :method   => 'GET',
            :path     => '/v2/groups/#{clc_alias}'
          )
        end

      end

      class Mock

        def list_groups
          Fog::Mock.not_implemented
          #response = Excon::Response.new
          #response.status = 200
          #response.body = {
          #}
          #response
        end

      end
    end
  end
end
