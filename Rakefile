require 'rubygems'
require "bundler"
Bundler.setup
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "shelltoad"
    gemspec.summary = "Command line interface for hoptoad (http://hoptoadapp.com)"
    gemspec.description = <<-EOI

EOI
    gemspec.email = "agresso@gmail.com"
    gemspec.homepage = "http://github.com/railsware/shelltoad"
    gemspec.authors = ["Bogdan Gusiev"]
    gemspec.executables = ["shelltoad"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: [sudo] gem install jeweler"
end
