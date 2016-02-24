require 'fog/core/model'
require 'fog/compute/models/server'
require 'fog/clc/models/compute/public_ip'

module Fog
  module Compute
    class CLC

      class LB < Fog::Compute::Server
        include Fog::CLC::Common

        identity  :id

        attribute :dc
        attribute :name
        attribute :description
        attribute :status
        attribute :ip_address,       :aliases => "ipAddress"
        attribute :pools,            :type => :array

        def create(dc)
          requires :dc, :name
          block_status do
            service.create_lb(dc, name, description, status)
          end
        end

        def read
          requires :id
          merge_attributes(service.get_lb(dc, id))
        end
      end
    end
  end
end
