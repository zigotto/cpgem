require "httparty"

module Cpgem

  class Request
    include HTTParty
  end

  class Gem

    def self.info(gem_name)
      response = Request.get("https://rubygems.org/api/v1/gems/#{gem_name}.json")
    end

  end

end
