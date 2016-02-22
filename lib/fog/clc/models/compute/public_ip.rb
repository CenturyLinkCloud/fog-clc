module Fog
  module Compute
    class CLC
      module PublicIPMixin
        # intended purely as mixin to Server
        # eg :id refers to server identity
        def add_public_ip(internal_ip=nil, ports=nil, restrictions=nil)
          # internal_ip optional
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
