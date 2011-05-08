require 'rubygems'
require "bundler"
Bundler.setup
require "net/http"
require 'rspec'
require "mocha"
require "fakeweb"
require "http_logger"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'..','lib'))
require "shelltoad"

require "fileutils"
require "logger"

FileUtils.rm_f("http.log")
Net::HTTP.logger = Logger.new("http.log")

TEST_ERROR = 4040123

TESTOUT = "" unless defined?(TESTOUT)

Shelltoad.const_set("OUTPUT", TESTOUT)

RSpec.configure do |config|
  config.mock_with :mocha


  config.before(:each) do
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(
      :any,
      %r|http://startdatelabs.hoptoadapp.com/errors.xml|,
      :body => File.new("spec/assets/errors.xml").read
    )
    FakeWeb.register_uri(
      :any,
      %r|http://startdatelabs.hoptoadapp.com/errors/#{TEST_ERROR}.xml|,
      :body => File.new("spec/assets/error.xml").read
    )
    FakeWeb.register_uri(
      :put,
      "http://startdatelabs.hoptoadapp.com/errors/4040123.xml" ,
      :body => File.read('spec/assets/error.xml')
    )

  end

  config.after(:each) do
    FakeWeb.clean_registry
    TESTOUT.gsub!(/.*\n*/, '')
  end

end



