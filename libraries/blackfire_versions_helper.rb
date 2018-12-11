require 'net/http'
require 'json'

module Blackfire
  class Versions
    @endpoint = 'https://blackfire.io'

    def self.agent(node = nil)
      fetch_versions(node)['agent']
    end

    def self.probe(node = nil)
      fetch_versions(node)['probe']['php']
    end

    def self.fetch_versions(node = nil)
      return @versions if @versions

      @versions = JSON.parse(fetch_releases(node))
    end

    def self.fetch_releases(node = nil)
      uri = URI.parse("#{get_endpoint(node)}/api/v1/releases")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      response = http.get(uri.request_uri)

      raise 'Unable to fetch Blackfire versions' unless response.code == '200'

      response.body
    end

    def self.get_endpoint(node = nil)
      return node['blackfire']['releases_endpoint'] if node && node['blackfire'].key?('releases_endpoint')

      @endpoint
    end
  end
end
