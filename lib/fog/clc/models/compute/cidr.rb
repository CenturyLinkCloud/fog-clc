module Fog
  module Compute
    class CLC
      # Wrapper around JSON object representing PublicIP CIDR block
      class CIDR < Fog::Model
        attribute :cidr

        def to_json(*args)
          Fog::JSON.encode({ :cidr => self.cidr })
        end
      end
    end
  end
end
