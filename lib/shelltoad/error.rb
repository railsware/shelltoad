require "active_support/core_ext/hash/conversions"
require "active_support/core_ext/hash/indifferent_access"
require "net/http"
require "uri"
require "cgi"

class Shelltoad::Error

  URL = URI.parse("http://#{::Shelltoad::Configuration.project}.hoptoadapp.com")

  #
  # Class methods
  #
  
  def self.all(*args)
    parse(http_get("/errors.xml"))[:groups].map! do |attributes|
      self.new(attributes)
    end
  end

  def self.magic_find(id)
    error = self.all(:show_resolved => true).find do |error|
      error.id.to_s =~ /#{id}$/
    end
    raise ErrorNotFound, "Error with id:#{id} not found" unless error
    if block_given?
      yield(error)
    end
    error
  end

  #
  # API
  #
  
  def initialize(attributes)
    @attributes = attributes
  end

  def data
    @data ||= self.class.parse(self.class.http_get(path('xml')))[:group]
  end

  def view
    <<-EOI
#{data[:error_message]}
#{data[:backtrace][:line].join("\n")}
EOI
  end

  def commit!
    message = <<-EOI.gsub(/`/, "'")
    #{url}

    #{self.error_message}
    EOI
    output = `git commit -m "#{message}"`
    if $?.success?
      resolve!
    end
    output
  end

  def resolve!
    return true if self.resolved?
    response = Net::HTTP.post_form(
      url,
      :"group[resolved]" => 1,
      :format => "xml",
      :_method => :put,
      :auth_token => ::Shelltoad::Configuration.key
    )
    raise "HTTP error: #{response}" unless response.is_a?(Net::HTTPSuccess)
    true
  end


  def to_s
    "[##{self.id}] #{self.rails_env.first} #{self.error_message} #{self.file}:#{self.line_number}"
  end

  def id
    @attributes[:id]
  end

  def resolved?
    @attributes[:resolved]
  end

  def method_missing(meth, *args, &blk)
    if attr = @attributes[meth]
      attr
    else
      super(meth, *args, &blk)
    end
  end

  #
  # Implementation
  #
  
  protected
  def path(format = nil)
    "/errors/#{self.id}" + (format ? ".#{format}" : "")
  end

  def url(format = nil)
    URI.parse(URL.to_s + path(format))
  end

  def self.http_get(path, params = {})
    params[:auth_token] = ::Shelltoad::Configuration.key
    query = path + "?" + params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
    return Net::HTTP.get(URL.host, query)
  end

  def self.parse(string)
    Hash.from_xml(string).with_indifferent_access
  end

end

