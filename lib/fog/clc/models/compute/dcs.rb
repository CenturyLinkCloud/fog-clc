require 'fog/core/collection'

module Fog
  module Compute
    class CLC
      class Dcs < Fog::Collection

        model Fog::Compute::CLC::DC

        def all
          raise StandardError, "this operation is unsupported on CLC"
        end

        def get(dc)
          if d = service.get_dc(dc)
            new(d)
          end
        end

      end
    end
  end
end
