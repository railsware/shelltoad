require "yaml"


class ShellToad
end
class ShellToad::Configuration

  def self.instance
    @instance ||= self.new
  end

  def initialize
    if File.exists?(".shelltoadrc")
      @config = YAML.load(File.new(".shelltoadrc"))
    else
      raise NoConfigfile, "No .shelltoadrc file under current directory"
    end
  end

  def self.key
    self.instance.key
  end

  def self.project
    self.instance.project
  end

  def key
    @config["key"] || raise(NoApiKey, "key option not specified in .shelltoadrc")
  end

  def project
    @config["project"] || raise(NoProject, "project option not specified in .shelltoadrc")
  end
end
  
