require 'fog/core/model'
require 'fog/clc/models/compute/pool'

module Fog
  module Compute
    class CLC

      class LB < Fog::Model
        include Fog::CLC::Common

        identity  :id

        attribute :dc
        attribute :name
        attribute :description
        attribute :status
        attribute :ip_address,       :aliases => "ipAddress"
        attribute :pools,            :type => :array
        attribute :links,            :type => :array

        METHODS = %w( roundRobin leastConnection )
        PERSISTENCE = %w( standard sticky )

        def initialize(attrs)
          inst = super(attrs)
          inst.set_dc
          inst.set_pools
          inst
        end

        def create
          requires :dc, :name
          merge_attributes(service.create_lb(dc, name, description, status))
        end

        def read
          requires :id
          merge_attributes(service.get_lb(dc, id))
          set_pools
          self
        end

        def update
          requires :id
          service.update_lb(dc, id)
        end

        def destroy
          requires :id
          service.delete_lb(dc, id)
        end

        def add_pool(port, method=METHODS.first, persistence=PERSISTENCE.first)
          self.pools << service.create_pool(dc, id, port, method, persistence)
          set_pools
        end



        protected

        def set_pools
          self.pools = (self.pools || []).map do |h|
            if h.is_a?(Hash)
              Fog::Compute::CLC::Pool.new(h.merge(:service => service))
            else
              h
            end
          end
        end
      end
    end
  end
end
