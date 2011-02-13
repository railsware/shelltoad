require "active_resource"
require "net/http"
require "uri"
require "cgi"

class Shelltoad::Error < ActiveResource::Base
  URL = URI.parse("http://#{::Shelltoad::Configuration.project}.hoptoadapp.com")
  self.site = URL.to_s

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

  def data
    @data ||= Hash.from_xml(http_get("/errors/#{self.id}.xml", :auth_token => ::Shelltoad::Configuration.key)).with_indifferent_access[:group]
  end
  def view
    <<-EOI
#{data[:error_message]}
#{data[:backtrace][:line].join("\n")}
EOI
  end

  def http_get(path, params = {})
    query = path + "?" + params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
    return Net::HTTP.get(URL.host, query)
  end

  def to_s
    "[##{self.id}] #{self.rails_env.first} #{self.error_message} #{self.file}:#{self.line_number}"
  end


end

