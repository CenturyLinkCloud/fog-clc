require 'fog/core/collection'
require 'fog/clc/models/compute/lb'

module Fog
  module Compute
    class CLC
      # Collection methods for SharedLoadBalancer
      class Lbs < Fog::Collection

        model Fog::Compute::CLC::LB

        def all
          raise StandardError, "this operation is unsupported on CLC. call :dc"
        end

        def in_dc(dcname)
          service.get_lb(dcname, nil).map {|h| new(h) }
        end

        def get(dc, id)
          new(service.get_lb(dc, id))
        end

      end
    end
  end
end
