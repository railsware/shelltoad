require "active_resource"

class Shelltoad::Error < ActiveResource::Base
  self.site = "http://#{::Shelltoad::Configuration.project}.hoptoadapp.com"

  class << self
    @@auth_token = ::Shelltoad::Configuration.key

    def find(*arguments)
      arguments = append_auth_token_to_params(*arguments)
      super(*arguments)
    end

    def append_auth_token_to_params(*arguments)
      opts = arguments.last.is_a?(Hash) ? arguments.pop : {}
      opts = opts.has_key?(:params) ? opts : opts.merge(:params => {})
      opts[:params] = opts[:params].merge(:auth_token => @@auth_token)
      arguments << opts
      arguments
    end
  end

  def self.all(*args)
    self.find :all, *args
  end

  def self.magic_find(id)
    self.all(:params => {:show_resolved => true}).find do |error|
      error.id.to_s =~ /#{id}$/
    end
  end

  def to_s
    "[##{self.id}] #{self.rails_env.first} #{self.error_message} #{self.file}:#{self.line_number}"
  end


end

