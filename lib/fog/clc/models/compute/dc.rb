require 'fog/core/model'


module Fog
  module Compute
    class CLC

      class DC < Fog::Model
        include Fog::CLC::Common

        attribute :id
        attribute :name
        attribute :links,             :type => :array
        attribute :templates,         :type => :array, :aliases => "templates"
        attribute :networks,          :type => :array, :aliases => "deployableNetworks"
        attribute :enabled,           :type => :boolean, :aliases => "dataCenterEnabled"
        attribute :bare_metal,        :type => :boolean, :aliases => "supportsBareMetalServers"
        attribute :load_balancers,    :type => :boolean, :aliases => "supportsSharedLoadBalancer"
        attribute :premium_storage,   :type => :boolean, :aliases => "supportsPremiumStorage"
        attribute :import_vm,         :type => :boolean, :aliases => "importVMEnabled"

        attribute :group_ids,         :type => :array

        def initialize(attrs)
          inst = super(attrs)
          inst.set_groups
          inst
        end

        def read
          requires :id
          merge_attributes(service.get_dc(id))
        end

        def load_capabilities
          requires :id
          merge_attributes(service.get_dc_capabilities(id))
        end

        protected
        
        def set_groups
          self.group_ids = self.links.map do |l|
            l['id'] if l['rel'] == 'group' 
          end.compact
        end
      end
    end
  end
end
