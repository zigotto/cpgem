require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Cpgem::Gem do

  context "when invalid gem" do

    use_vcr_cassette "invalid_gem", :record => :new_episodes

    it "should raise error" do
      expect { Cpgem::Gem.info("xpto_gem_not_found") }.to raise_error(/This rubygem could not be found./)
    end

  end

  context "when search" do

    use_vcr_cassette "search_googl", :record => :new_episodes

    it "should return some basic information about the gem" do
      info = Cpgem::Gem.info("googl")
      info.should == {"dependencies"=>{"runtime"=>[{"name"=>"httparty", "requirements"=>">= 0.6.1"}, {"name"=>"json", "requirements"=>">= 1.4.6"}], "development"=>[{"name"=>"bundler", "requirements"=>"~> 1.0.0"}, {"name"=>"jeweler", "requirements"=>"~> 1.5.2"}, {"name"=>"rcov", "requirements"=>">= 0"}, {"name"=>"rspec", "requirements"=>"~> 2.3.0"}, {"name"=>"webmock", "requirements"=>"~> 1.6.2"}]}, "name"=>"googl", "downloads"=>3854, "info"=>"Small library for Google URL Shortener API", "version_downloads"=>1357, "version"=>"0.5.0", "homepage_uri"=>"http://github.com/zigotto/googl", "bug_tracker_uri"=>"https://github.com/zigotto/googl/issues", "source_code_uri"=>"https://github.com/zigotto/googl", "gem_uri"=>"http://rubygems.org/gems/googl-0.5.0.gem", "project_uri"=>"http://rubygems.org/gems/googl", "authors"=>"Jesus Lopes", "mailing_list_uri"=>"", "documentation_uri"=>"", "wiki_uri"=>""} 
    end

  end

end
