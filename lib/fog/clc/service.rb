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
        agent = "fog-clc/#{Fog::CLC::VERSION}"
        { 'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'User-Agent' => agent,
          'Api-Client' => agent,
          'Authorization' => @auth ? "Bearer #{@auth['bearerToken']}" : "",
        }.merge(options[:headers] || {})
      end

      def authenticate(options={})
        @auth ||= begin
                    @clc_username = options[:clc_username] || ENV['CLC_USERNAME']
                    @clc_password = options[:clc_password] || ENV['CLC_PASSWORD']
                    @clc_alias    = options[:clc_alias] || ENV['CLC_ALIAS']
                    creds = { :username => @clc_username, :password => @clc_password }
                    request(:expects => [200],
                            :method  => 'POST',
                            :path    => '/v2/authentication/login',
                            :body    => Fog::JSON.encode(creds))

                  end
      end

    end
  end
end
