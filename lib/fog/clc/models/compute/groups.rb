require 'fog/core/collection'

module Fog
  module Compute
    class CLC
      class Groups < Fog::Collection

        model Fog::Compute::CLC::Group

        def all
          raise StandardError, "this operation is unsupported on CLC"
        end

        def get(id)
          if g = service.get_group(id)
            new(g)
          end
        end

      end
    end
  end
end
