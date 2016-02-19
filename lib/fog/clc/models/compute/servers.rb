require 'fog/core/collection'
require 'fog/clc/models/compute/server'

module Fog
  module Compute
    class CLC
      class Servers < Fog::Collection

        model Fog::Compute::CLC::Server

        def all
          raise StandardError, "this operation is unsupported on CLC"
        end
        
        def get(id)
          if s = service.get_server(id)
            new(s)
          end
        end

      end
    end
  end
end

