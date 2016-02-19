module Fog
  module Compute
    class CLC 
      class Real
        def delete_server(id)
          request(
            :expects  => [200, 202],
            :method   => 'DELETE',
            :path     => "/v2/servers/#{clc_alias}/#{id}"
          )
        end
      end

      class Mock

        def delete_server(id)
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
