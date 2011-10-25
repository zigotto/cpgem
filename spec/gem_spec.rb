require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Cpgem::Gem do

  context "when invalid gem" do

    use_vcr_cassette "invalid_gem", :record => :new_episodes

    it "should raise error" do
      expect { Cpgem::Gem.info("xpto_gem_not_found") }.to raise_error(/This rubygem could not be found./)
    end

  end

  context "basic information about the gem" do

    use_vcr_cassette "search_googl", :record => :new_episodes

    let(:info) {
      Cpgem::Gem.info("googl")
    }

    it { info.dependencies["runtime"].should == [{"name"=>"httparty", "requirements"=>">= 0.6.1"}, {"name"=>"json", "requirements"=>">= 1.4.6"}] }
    it { info.dependencies["development"].should == [
      {"name"=>"bundler", "requirements"=>"~> 1.0.0"},
      {"name"=>"jeweler", "requirements"=>"~> 1.5.2"},
      {"name"=>"rcov", "requirements"=>">= 0"},
      {"name"=>"rspec", "requirements"=>"~> 2.3.0"},
      {"name"=>"webmock", "requirements"=>"~> 1.6.2"}
    ]}

    it { info.name.should == "googl" }
    it { info.downloads.should == 3854 }
    it { info.info.should == "Small library for Google URL Shortener API" }
    it { info.version_downloads.should == 1357 }
    it { info.version.should == "0.5.0" }
    it { info.homepage_uri.should == "http://github.com/zigotto/googl" }
    it { info.bug_tracker_uri.should == "https://github.com/zigotto/googl/issues" }
    it { info.source_code_uri.should == "https://github.com/zigotto/googl" }
    it { info.gem_uri.should == "http://rubygems.org/gems/googl-0.5.0.gem" }
    it { info.project_uri.should == "http://rubygems.org/gems/googl" }
    it { info.authors.should == "Jesus Lopes" }
    it { info.mailing_list_uri.should == "" }
    it { info.documentation_uri.should == "" }
    it { info.wiki_uri.should == "" }

  end

  describe "#gemfile_line" do

    use_vcr_cassette "search_simplecov", :record => :new_episodes

    let(:info) {
      Cpgem::Gem.info("simplecov")
    }

    it "should return line to past in Gemfile" do
      info.gemfile_line.should == 'gem "simplecov", "~> 0.5.4"'
    end

    it "should accept group option" do
      info.gemfile_line(:group => :development).should == 'gem "simplecov", "~> 0.5.4", :group => :development'
      info.gemfile_line(:group => "development").should == 'gem "simplecov", "~> 0.5.4", :group => :development'
    end

    it "should accept require option" do
      info.gemfile_line(:require => :false).should == 'gem "simplecov", "~> 0.5.4", :require => false'
    end

    it "should return line with all options" do
      info.gemfile_line(:group => :development, :require => :false).should == 'gem "simplecov", "~> 0.5.4", :group => :development, :require => false'
    end

  end

end
