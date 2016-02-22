require 'fog/core/connection'
require 'fog/compute'
require 'fog/clc'
require 'fog/clc/service'

module Fog
  module Compute

    class CLC < Fog::Service
      include Fog::CLC::Errors

      #class ServiceError < Fog::CLC::Errors::ServiceError; end
      #class InternalServerError < Fog::CLC::Errors::InternalServerError; end
      #class BadRequest < Fog::CLC::Errors::BadRequest; end

      requires :clc_username, :clc_password, :clc_alias

      model_path   'fog/clc/models/compute'
      model        :server
      collection   :servers

      request_path 'fog/clc/requests/compute'
      request      :get_status
      request      :create_server
      request      :get_server
      request      :update_server
      request      :delete_server
      request      :create_public_ip
      request      :get_public_ip
      request      :update_public_ip
      request      :delete_public_ip



      class Mock < Fog::CLC::Service

        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :servers => {},
              :images  => {},
            }
          end
        end

        def self.reset
          @data = nil
        end

        def data
          self.class.data[@clc_username]
        end

        def reset_data
          self.class.data.delete(@clc_username)
        end

      end

      class Real < Fog::CLC::Service

        def initialize(options={})
          @connection = Fog::Core::Connection.new(Fog::CLC::BASE, options[:persistent], options[:connection_options] || {})
          authenticate(options) unless @auth_token
        end

        def reload
          @connection.reset
        end

      end


    end
  end
end
