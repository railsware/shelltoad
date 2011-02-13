require "yaml"


class Shelltoad::Configuration

  def self.instance
    @instance ||= self.new
  end

  def initialize
    if File.exists?(".shelltoadrc")
      @config = YAML.load(File.new(".shelltoadrc"))
    else
      raise ::Shelltoad::NoConfigfile, "No .shelltoadrc file under current directory"
    end
  end

  def self.key
    self.instance.key
  end

  def self.project
    self.instance.project
  end

  def key
    @config && @config["key"] || raise(::Shelltoad::NoApiKey, "key option not specified in .shelltoadrc")
  end

  def project
    @config && @config["project"] || raise(::Shelltoad::NoProject, "project option not specified in .shelltoadrc")
  end
end
  
