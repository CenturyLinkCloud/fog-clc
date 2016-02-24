module Fog
  module Compute
    class CLC
      # Wrapper around JSON object representing PublicIP Port
      class Port < Fog::Model
        attribute :port,             :type => :integer
        attribute :port_to,          :type => :integer, :aliases => "portTo"
        attribute :protocol,         :aliases => "privatePort", :default => "TCP"
        def initialize(attrs)
          (attrs['protocol'] ||= 'TCP').upcase!
          super(attrs)
        end

        def to_json(*args)
          d = {
            :protocol => self.protocol,
            :port => self.port,
          }
          d[:portTo] = self.port_to if self.port_to
          Fog::JSON.encode(d)
        end
      end
    end
  end
end
