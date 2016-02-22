module Fog
  module Compute
    class CLC
      class CIDR
        attr_accessor :cidr_block

        def initialize(cidr_block)
          self.cidr_block = cidr_block
        end

        def to_json(*args)
          Fog::JSON.encode({ :cidr => self.cidr_block })
        end
      end
    end
  end
end
