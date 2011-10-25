require "httparty"

module Cpgem

  class Request
    include HTTParty
  end

  class Gem

    attr_accessor :dependencies, :name, :downloads, :info, :version_downloads, :version,
      :homepage_uri, :bug_tracker_uri, :source_code_uri, :gem_uri, :project_uri, :authors,
      :mailing_list_uri, :documentation_uri, :wiki_uri

    def initialize(response)
      response.each {|name, value| send("#{name}=", value)}
    end

    def self.info(gem_name)
      response = Request.get("https://rubygems.org/api/v1/gems/#{gem_name}.json")
      case response.code
      when 200
        Gem.new(response)
      else
        raise "#{response.code} #{response.message}"
      end
    end

  end

end
