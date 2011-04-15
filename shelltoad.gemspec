# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{shelltoad}
  s.version = "0.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bogdan Gusiev"]
  s.date = %q{2011-04-15}
  s.default_executable = %q{shelltoad}
  s.description = %q{
}
  s.email = %q{agresso@gmail.com}
  s.executables = ["shelltoad"]
  s.files = [
    "Changelog.textile",
    "Gemfile",
    "Gemfile.lock",
    "Rakefile",
    "Readme.textile",
    "VERSION",
    "bin/shelltoad",
    "lib/shelltoad.rb",
    "lib/shelltoad/command.rb",
    "lib/shelltoad/configuration.rb",
    "lib/shelltoad/error.rb",
    "lib/shelltoad/exceptions.rb",
    "shelltoad.gemspec",
    "spec/assets/error.xml",
    "spec/assets/errors.xml",
    "spec/shelltoad/error_spec.rb",
    "spec/shelltoad_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/railsware/shelltoad}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Command line interface for hoptoad (http://hoptoadapp.com)}
  s.test_files = [
    "spec/shelltoad/error_spec.rb",
    "spec/shelltoad_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<hoptoad-api>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<hoptoad-api>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<hoptoad-api>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

