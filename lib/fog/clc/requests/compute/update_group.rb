module Fog
  module Compute
    class CLC
      class Real
        def update_group(id, data)
          request(
            :expects  => [200, 201, 202],
            :method   => "PUT",
            :path     => "/v2/groups/#{clc_alias}/#{id}",
            :body     => Fog::JSON.encode(data),
          )
        end
      end

      class Mock
        def update_group(id)
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
