require 'fog/core/collection'

module Fog
  module Compute
    class CLC
      class Groups < Fog::Collection

        model Fog::Compute::CLC::Group

        def all
          raise StandardError, "this operation is unsupported on CLC"
        end

        def in_dc(dcname)
          dc = Fog::Compute::CLC::DC.new(service.get_dc(dcname))
          dc.group_ids.map {|id| new(service.get_group(id)) }
        end

        def get(id)
          new(service.get_group(id))
        end

      end
    end
  end
end
