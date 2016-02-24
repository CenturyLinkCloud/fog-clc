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


        def initialize(attrs)
          inst = super(attrs)
          inst.set_dc
          inst.set_pools
          inst
        end

        def create(dc)
          requires :dc, :name
          block_status do
            service.create_lb(dc, name, description, status)
          end
        end

        def read
          requires :id
          merge_attributes(service.get_lb(dc, id))
          set_pools
          self
        end

        protected

        def set_pools
          self.pools = (self.pools || []).map do |h|
            if h.is_a?(Hash)
              Fog::Compute::CLC::Pool.new(h)
            else
              h
            end
          end
        end
      end
    end
  end
end
