require "yaml"
require "hoptoad-api"


class Shelltoad::Configuration

  #
  # Class methods
  #
  
  def self.key
    self.instance.key
  end

  def self.project_id
    self.instance.project_id
  end
  
  def self.secure?
    self.instance.secure
  end

  def self.account
    self.instance.account
  end

  def self.instance
    @instance ||= self.new
  end

  #
  # API
  #
  
  def initialize
    if File.exists?(".shelltoadrc")
      @config = YAML.load(File.new(".shelltoadrc"))
    else
      raise ::Shelltoad::NoConfigfile, "No .shelltoadrc file under current directory"
    end
  end

  def key
    @config["key"] || raise(::Shelltoad::NoApiKey, "key option not specified in .shelltoadrc")
  end

  def project_id
    @config["project_id"]
  end

  def account
    (@config["account"] || @config["project"]) || raise(::Shelltoad::BaseException, "account option not specified in .shelltoadrc")
  end

  def secure
    @config["secure"] # false by default
  end

end
  
Hoptoad.auth_token = Shelltoad::Configuration.key
Hoptoad.account = Shelltoad::Configuration.account
Hoptoad.secure = Shelltoad::Configuration.secure?
