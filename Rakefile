require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
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
    gemspec.add_dependency "activeresource"
    gemspec.executables = ["shelltoad"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: [sudo] gem install jeweler"
end
