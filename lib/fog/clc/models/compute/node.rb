require 'fog/core/model'

module Fog
  module Compute
    class CLC
      # Wrapper around JSON object representing LoadBalancerPool Node
      class Node < Fog::Model
        attribute :status
        attribute :ip_address,       :aliases => "ipAddress"
        attribute :private_port,     :aliases => "privatePort"
      end
    end
  end
end
