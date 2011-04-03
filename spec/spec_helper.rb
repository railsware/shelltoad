require 'rubygems'
require "bundler"
Bundler.setup
require "net/http"
require 'rspec'
require "mocha"
require "fakeweb"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'..','lib'))
require "shelltoad"


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
      :post,
      "http://startdatelabs.hoptoadapp.com/errors/4040123" ,
      :body => File.read('spec/assets/error.xml')
    )

  end

  config.after(:each) do
    FakeWeb.clean_registry
    TESTOUT.gsub!(/.*\n*/, '')
  end

end


