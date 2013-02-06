require "httparty"
require "crack/json"

module Cpgem

  class Request
    include HTTParty
    parser(
      Proc.new do |body, format|
        Crack::JSON.parse(body)
      end
    )
  end

  class Gem

    attr_accessor :dependencies, :name, :downloads, :info, :version_downloads, :version,
      :homepage_uri, :bug_tracker_uri, :source_code_uri, :gem_uri, :project_uri, :authors,
      :mailing_list_uri, :documentation_uri, :wiki_uri, :platform

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

    def gemfile_line(options={})
      line = ""
      line << "gem \"#{name}\", \"~> #{version}\""
      line << ", :group => :#{options[:group]}" if options[:group]
      line << ", :require => #{options[:require]}" if options[:require]
      line
    end

    def to_clipboard(line=gemfile_line)
      Clipboard.copy(line)
    end

    def output_message
      Clipboard.clear
      to_clipboard
      message = %@Gemfile: gem "#{name}", "~> #{version}"
install: gem install #{name}
name: #{name}
version: #{version}
#{downloads} downloads
#{version_downloads} for this version
homepage: #{homepage_uri}@
    end

  end

end
