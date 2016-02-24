module Fog
  module Compute
    class CLC
      class Real
        def create_group(name, description, parent_group_id)
          request(
            :expects  => [200, 201],
            :method   => "POST",
            :path     => "/v2/groups/#{clc_alias}",
            :body     => Fog::JSON.encode(
                        {
                          :name => name,
                          :description => description,
                          :parentGroupId => parent_group_id,
                        }
                      )
          )
        end
      end

      class Mock
        def create_group
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
