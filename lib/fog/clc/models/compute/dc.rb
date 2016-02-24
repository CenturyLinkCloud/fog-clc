require 'fog/core/model'


module Fog
  module Compute
    class CLC

      class DC < Fog::Model
        include Fog::CLC::Common

        attribute  :id
        attribute :name
        attribute :groups,            :type => :array

        def initialize(attrs)
          links = attrs['links']
          attrs['groups'] = links.map do |l|
            next unless l['rel'] == 'group'
            l['id']
          end.compact
          super(attrs)
        end

        def get(dc)
          service.get_dc(dc)
        end

      end
    end
  end
end
