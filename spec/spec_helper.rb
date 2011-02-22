require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'active_record'
require "fakeweb"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'..','lib'))
require "shelltoad"

Spec::Runner.configure do |config|
end
