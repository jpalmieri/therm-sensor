require_relative "../config.rb"
require 'net/http'
require 'uri'
require 'json'

module Therm
  class HTTPClient
    class ThermClientError < StandardError
    end

    def initialize
      @base_uri = BASE_URL
      @auth_token = get_token
    end

    def post(target, options)
      uri = URI("#{@base_uri}#{target}")
      request = post_request(uri, options, @auth_token)
      return process_http_response(uri, request)
    end

    def get(target, options={})
      uri = URI("#{@base_uri}#{target}")
      request = get_request(uri, options, @auth_token)
      return process_http_response(uri, request)
    end

    private

    def get_token
      uri = URI("#{@base_uri}/auth/login")
      options = {
        email: EMAIL,
        password: PASSWORD
      }
      request = post_request(uri, options)
      return process_http_response(uri, request)
    end

    def get_request(uri, options, auth_token=nil)
      request = Net::HTTP::Get.new(uri)
      request.body = options.to_json
      request.content_type = 'application/json'
      if auth_token
        request['Authorization'] = auth_token
      end
      return request
    end

    def post_request(uri, options, auth_token=nil)
      request = Net::HTTP::Post.new(uri)
      request.body = options.to_json
      request.content_type = 'application/json'
      if auth_token
        request['Authorization'] = auth_token
      end
      return request
    end

    def process_http_response(uri, request)
      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end

      case response
      when Net::HTTPSuccess
        return JSON.parse(response.body)
      else
        raise ThermClientError, response.message
      end
    end
  end
end
