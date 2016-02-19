module Fog
  module Compute
    class CLC 
      class Real

        def update_server(id, body)
          request(
            :expects  => [200, 202],
            :method   => 'PATCH',
            :path     => "/v2/servers/#{clc_alias}/#{id}",
            :body     => Fog::JSON.encode(body)
          )
        end

      end

      class Mock

        def update_server(id, attributes = {})
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
