require 'fog/core/collection'
require 'fog/clc/models/compute/lb'

module Fog
  module Compute
    class CLC
      # Collection methods for SharedLoadBalancer
      class Pools < Fog::Collection

        model Fog::Compute::CLC::Pool

        def all
          raise StandardError, "this operation is unsupported on CLC. call with :dc and :lb"
        end

        def on_lb(lb)
          service.get_lb(dcname, lb).map {|h| Fog::Compute::CLC::Pool.new(h) }
        end

        def get(dc, lb, id)
          new(service.get_pool(dc, lb, id))
        end

      end
    end
  end
end
