# intended purely as mixin to Server
# (since we're only ever updating an ip off of an existing server_
module Fog
  module Compute
    class CLC
      module PublicIP

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

        class CIDR
          attr_accessor :cidr_block

          def initialize(cidr_block)
            self.cidr_block = cidr_block
          end

          def to_json(*args)
            Fog::JSON.encode({ :cidr => self.cidr_block })
          end
        end
            
        
        def add_public_ip(internal_ip=nil, ports=nil, restrictions=nil)
          # optional ip internal ip address
          requires :id
          block_status do 
            service.create_public_ip(id, internal_ip, ports, restrictions)
          end
        end
        
        def get_public_ip(public_ip)
          requires :id
          service.get_public_ip(id, public_ip)
        end
        
        def update_public_ip(public_ip, ports=nil, restrictions=nil)
          requires :id
          block_status do 
            service.update_public_ip(id, public_ip, ports, restrictions)
          end
        end
        
        def remove_public_ip(public_ip)
          requires :id
          block_status do
            service.delete_public_ip(id, public_ip)
          end
        end
        
      end
    end
  end
end
