require 'fog/core/collection'
require 'fog/clc/models/compute/lb'

module Fog
  module Compute
    class CLC
      class Lbs < Fog::Collection

        model Fog::Compute::CLC::LB

        def all
          raise StandardError, "this operation is unsupported on CLC"
        end

        def get(dc, id)
          if l = service.get_lb(dc, id)
            new(l)
          end
        end

      end
    end
  end
end
