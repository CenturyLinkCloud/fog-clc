require 'fog/core/model'

module Fog
  module Compute
    class CLC

      class Group < Fog::Model
        include Fog::CLC::Common

        identity  :id

        attribute :name
        attribute :description
        attribute :type
        attribute :status
        attribute :parent_group_id,  :aliases => "parentGroupId"
        attribute :groups,           :type => :array
        attribute :customFields,     :type => :array
        attribute :links,            :type => :array
        attribute :servers_count,    :aliases => "serversCount"
        attribute :location_id,      :aliases => "locationId"
        alias :dc :location_id

        def initialize(attrs)
          id = attrs['id']
          inst = super(attrs)
          inst.set_parent
          inst.set_subgroups
          inst
        end

        def save
          if identity
            update
          else
            create
          end
        end

        def create
          merge_attributes(service.create_group(name, description, parent_group_id))
        end

        def read
          requires :id
          merge_attributes(service.get_group(id))
          set_parent
          set_subgroups
          self
        end

        def update
          requires :id
          patches = []
          mapping = {
            'parent_group_id' => 'parentGroupId',
            'custom_fields' => 'customFields'
          }
          %w( name description parent_group_id custom_fields ).each do |p|
            patches << {
              :op => :set,
              :member => mapping[p] || p,
              :value => send(p.to_sym),
            }
          end
          service.update_group(id, patches)
          read
        end

        def destroy
          requires :id
          block_status do
            service.delete_group(id)
          end
        end

        def servers
          self.links.map do |l|
            l['id'] if l['rel'] == 'server'
          end.compact
        end

        def power=(val)
          raise ArgumentError, "no servers in this group" if servers.empty?
          service.set_power_state(val, self.servers).map do |resp|
            block_status { resp } if resp['isQueued']
          end
        end

        protected

        def set_parent
          parent = (self.links || []).select do |l|
            l['rel'] == 'parentGroup' && id != l['id']
          end.first
          if parent
            self.parent_group_id = parent['id']
          end
        end

        def set_subgroups
          self.groups = (self.groups || []).map do |h|
            Group.new(h) unless h.is_a?(Group)
          end
        end

      end
    end
  end
end
