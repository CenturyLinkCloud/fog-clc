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
        attribute :servers_count,    :aliases => "serversCount"
        attribute :location_id,      :aliases => "locationId"


        def initialize(attrs)
          id = attrs['id']

          parent = (attrs['links'] || []).select do |l|
            l['rel'] == 'parentGroup' && id != l['id']
          end.first
          if parent
            attrs['parentGroupId'] = parent['id']
          end

          attrs['groups'] = (attrs['groups'] || []).map do |h|
            Group.new(h)
          end
          super(attrs)
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

        def destroy
          requires :id
          block_status do
            service.delete_group(id)
          end
        end
      end

    end
  end
end
