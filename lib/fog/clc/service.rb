require 'fog/json'

module Fog
  module CLC
    class Service
      attr_reader :clc_username, :clc_password, :clc_alias

      def request(params={})
        params[:headers] = headers(params)
        process_response(@connection.request(params))
      end

      private

      def process_response(response)
        if response && response.body &&
           response.body.is_a?(String) &&
           !response.body.strip.empty?
          begin
            response.body = Fog::JSON.decode(response.body)
          rescue Fog::JSON::DecodeError => e
            Fog::Logger.warning("Error Parsing response json - #{e}")
            response.body = {}
          end
        end
      end

      def headers(options={})
        { 'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'User-Agent' => "CenturyLinkCloud/fog-clc",
          'Authorization' => @auth_data ? "Bearer #{@auth_data['bearerToken']}" : "",
        }.merge(options[:headers] || {})
      end
      
      def authenticate(options={})
        @clc_username ||= options[:clc_username] || ENV['CLC_USERNAME']
        @clc_password ||= options[:clc_password] || ENV['CLC_USERNAME']
        res = request :method  => 'POST', 
                                  :path    => '/v2/authentication/login',
                                  :expects => [200],
                                  :body    => Fog::JSON.encode({ 
                                    :username => @clc_username, 
                                    :password => @clc_password
                                  })
        @clc_alias ||= res['accountAlias']
        @auth_data = res
      end

    end
  end
end

