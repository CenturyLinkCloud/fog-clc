require 'fog/core/model'
require 'fog/clc/models/compute/node'

module Fog
  module Compute
    class CLC

      class Pool < Fog::Model
        include Fog::CLC::Common

        identity  :id

        attribute :dc
        attribute :lb
        attribute :port
        attribute :method
        attribute :persistence
        attribute :nodes,            :type => :array
        attribute :links,            :type => :array


        def initialize(attrs)
          inst = super(attrs)
          inst.set_dc
          inst.set_lb
          inst.set_nodes
          inst
        end
        
        def create(lb)
          requires :port
          block_status do
            service.create_pool(lb, port, method, persistence)
          end
        end

        def read
          requires :id
          merge_attributes(service.get_pool(lb, id))
          set_dc
          set_lb
          set_nodes
          self
        end

        protected

        def set_nodes
          self.nodes = (self.nodes || []).map do |h|
            h.is_a?(Hash) ? Fog::Compute::CLC::Node.new(h) : h
          end
        end

        def set_lb
          # /v2/sharedLoadBalancers/{accountAlias}/{dataCenter}/{loadBalancerId}/pools/{poolId}
          self.lb = href.split('/')[5]
        end
      end
    end
  end
end
