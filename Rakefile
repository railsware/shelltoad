require 'rubygems'
require "bundler"
Bundler.setup

require 'rake'
require 'rspec/core/rake_task'
require 'jeweler'

RSpec::Core::RakeTask.new(:spec) do |spec|
end

Jeweler::Tasks.new do |gemspec|
  gemspec.name = "shelltoad"
  gemspec.summary = "Command line interface for hoptoad (http://hoptoadapp.com)"
  gemspec.description = <<-EOI

  EOI
  gemspec.email = "agresso@gmail.com"
  gemspec.homepage = "http://github.com/railsware/shelltoad"
  gemspec.authors = ["Bogdan Gusiev"]
end

task :default => :spec do
end
