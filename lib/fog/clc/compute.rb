require 'fog/clc/common'
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
      model        :dc
      collection   :dcs
      model        :server
      collection   :servers
      model        :group
      collection   :groups
      model        :port
      model        :cidr
      model        :lb
      collection   :lbs

      request_path 'fog/clc/requests/compute'
      request      :get_dc
      request      :get_dc_capabilities
      request      :get_status

      request      :create_server
      request      :get_server
      request      :update_server
      request      :delete_server
      request      :get_credentials

      request      :create_public_ip
      request      :get_public_ip
      request      :update_public_ip
      request      :delete_public_ip

      request      :create_lb
      request      :get_lb
      request      :update_lb
      request      :delete_lb

      request      :create_group
      request      :get_group
      request      :update_group
      request      :delete_group

      request      :set_power_state

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
          @connection = Fog::Core::Connection.new(
                        Fog::CLC::API_BASE,
                        options[:persistent],
                        options[:connection_options] || {})
          authenticate(options) unless @auth_token
        end

        def reload
          @connection.reset
        end

        # generic pass through for debug use
        def raw_request(opts={})
          request(opts)
        end

      end


    end
  end
end
