module Fog
  module Compute
    class CLC
      class Real

        def get_status(id)
          resp = request(
            :expects  => [200],
            :method   => 'GET',
            :path     => "/v2/operations/#{clc_alias}/status/#{id}"
          )
        end

      end

      class Mock

        def get_status(id)
          Fog::Mock.not_implemented
        end

      end
    end
  end
end
