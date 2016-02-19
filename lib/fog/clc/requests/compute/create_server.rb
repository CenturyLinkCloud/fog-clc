module Fog
  module Compute
    class CLC 
      class Real

        def create_server(data = {})
          resp = request(
            :expects  => [200, 201, 202],
            :method   => 'POST',
            :path     => "/v2/servers/#{clc_alias}",
            :body     => Fog::JSON.encode(data)
          )
        end

      end

      class Mock

        def create_server(attributes)
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
