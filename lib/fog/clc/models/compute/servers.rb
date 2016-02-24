require 'fog/core/collection'
require 'fog/clc/models/compute/server'

module Fog
  module Compute
    class CLC
      # Collection methods for Server
      class Servers < Fog::Collection

        model Fog::Compute::CLC::Server

        def all
          raise StandardError, "this operation is unsupported on CLC"
        end
        
        def get(id)
          new(service.get_server(id))
        end

      end
    end
  end
end

