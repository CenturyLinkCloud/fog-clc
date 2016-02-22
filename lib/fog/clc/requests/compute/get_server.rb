module Fog
  module Compute
    class CLC
      class Real
        def get_server(id)
          request(
            :expects  => [200],
            :method   => "GET",
            :path     => "/v2/servers/#{clc_alias}/#{id}"
          )
        end
      end

      class Mock
        def get_tasks(id)
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
