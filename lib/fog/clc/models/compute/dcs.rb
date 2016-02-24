require 'fog/core/collection'

module Fog
  module Compute
    class CLC
      # Datacenter Collection
      class Dcs < Fog::Collection

        model Fog::Compute::CLC::DC

        def all
          service.get_dc.map {|h| new(h) }
        end

        def get(dc)
          new(service.get_dc(dc))
        end

      end
    end
  end
end
