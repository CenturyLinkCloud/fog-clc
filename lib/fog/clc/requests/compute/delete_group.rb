module Fog
  module Compute
    class CLC
      class Real
        def delete_group(id)
          request(
            :expects  => [200, 202],
            :method   => "DELETE",
            :path     => "/v2/groups/#{clc_alias}/#{id}"
          )
        end
      end

      class Mock
        def delete_group(id)
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
