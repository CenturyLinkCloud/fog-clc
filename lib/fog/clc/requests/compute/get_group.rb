module Fog
  module Compute
    class CLC
      class Real

        def get_group(id)
          request(
            :expects  => [200],
            :method   => 'GET',
            :path     => '/v2/groups/#{clc_alias}/#{id}'
          )
        end

      end

      class Mock

        def get_group
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
