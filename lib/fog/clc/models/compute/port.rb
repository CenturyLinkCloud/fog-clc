module Fog
  module Compute
    class CLC
      class Port
        attr_accessor :port, :portTo, :protocol

        def initialize(port, portTo=nil, protocol=:TCP)
          self.port = port
          self.portTo = portTo
          self.protocol = protocol
        end

        def to_json(*args)
          d = {
            :protocol => self.protocol,
            :port => self.port,
          }
          d[:portTo] = self.portTo if self.portTo
          Fog::JSON.encode(d)
        end
      end
    end
  end
end
