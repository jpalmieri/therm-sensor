require 'net/http'
require 'uri'
require 'json'
require 'yaml'

module Therm
  class HTTPClient
    class ThermClientError < StandardError
    end

    def initialize
      @base_uri = config[:BASE_URL]
      @auth_token = fetch_token(config[:EMAIL], config[:PASSWORD])
    end

    def post(target, options)
      http_request(:post, target_uri(target), options, @auth_token)
    end

    def get(target, options={})
      http_request(:get, target_uri(target), options, @auth_token)
    end

    private

    def config
      @config ||= YAML.load_file(File.expand_path('../../config.yml', __FILE__)).transform_keys(&:to_sym)
    end

    def fetch_token(email, password)
      options = {
        email: email,
        password: password
      }
      return http_request(:post, target_uri("/auth/login"), options)
    end

    def http_request(request_type, uri, options, auth_token=nil)
      case request_type
      when :get
        request = Net::HTTP::Get.new(uri)
      when :post
        request = Net::HTTP::Post.new(uri)
      end
      request.body = options.to_json
      request.content_type = 'application/json'
      if auth_token
        request['Authorization'] = auth_token
      end
      response = process_request(uri, request)
      return process_response(response)
    end

    def process_request(uri, request)
      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end
      return response
    end

    def process_response(response)
      case response
      when Net::HTTPSuccess
        return JSON.parse(response.body)
      else
        raise ThermClientError, response.message
      end
    end

    def target_uri(target)
      URI("#{@base_uri}#{target}")
    end
  end
end
