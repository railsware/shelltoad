require "uri"
require "cgi"
require "hoptoad-api"

class Shelltoad
  class Error


    CACHE = {} # Runtime cache for http queries

    #
    # Class methods
    #

    def self.all(options = {})
      options[:project_id] ||= Configuration.project_id if Configuration.project_id
      CACHE[options] ||= (
        (Hoptoad::Error.find(:all, options) || []).map! do |attributes|
          self.new(attributes)
        end
      )
    end

    def self.magic_find(id)
      if !id || id.to_s.empty?
        Error.all.each do |error|
          output error.to_s
        end
        output "\n"
        id = Readline.readline("Input error id: ", true)
      end

      error = id.to_s.size > 5 ? simple_finder(id) : magic_finder(id)
      if block_given?
        return yield(error)
      end
      error
    end

    def self.magic_finder(id)
      1.upto(3) do |page|
        self.all(:show_resolved => true, :page => page).each do |error|
          return self.new(error) if error.id.to_s =~ /#{id}$/
        end
      end
      raise ErrorNotFound, "Error with id like *#{id} not found among last 90 errors.\n Try input full id."
    end

    def self.simple_finder(id)
      attributes = Hoptoad::Error.find(id) || raise(ErrorNotFound, "Error with id #{id} not found under this account.")
      self.new(attributes, true)
    end

    def self.output(*args)
      Shelltoad.output(*args)
    end

    def self.base_url
      URI.parse("#{Configuration.secure? ? "https" : "http"}://#{Configuration.account}.hoptoadapp.com")
    end


    #
    # API
    #

    def initialize(attributes, full = false)
      @attributes = attributes
      @data = attributes if full
    end

    def data
      @data ||= Hoptoad::Error.find(self.id)
    end

    def lines
      self.data[:backtrace][:line]
    end

    def view
      <<-EOI
      #{self.url.to_s}
      #{self.error_message}
      #{self.lines.join("\n")}
      EOI
    end


    def commit!(custom_message)
      
      message = ""
      unless custom_message.nil? || custom_message.strip.empty?
        message << custom_message + "\n"
        message << "\n"
      end
      message << url.to_s + "\n"
      if custom_message.nil? || custom_message.strip.empty?
        message << "\n"
      end
      message << self.error_message + "\n"
      message.gsub!(/`/, "'")

      output = `git commit -m "#{message}"`
      if $?.success?
        resolve!
      end
      output
    end

    def resolve!
      return true if self.resolved?
      Hoptoad::Error.put(path("xml"), :body => {:group => {:resolved => 1}})
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

    def [](key)
      @attributes[key] || self.data[key]
    end

    def url(format = nil)
      URI.parse(self.class.base_url.to_s + path(format))
    end



    #
    # Implementation
    #

    protected
    def path(format = nil)
      "/errors/#{self.id}" + (format ? ".#{format}" : "")
    end

    def method_missing(meth, *args, &blk)
      if attr = @attributes[meth]
        attr
      else
        super(meth, *args, &blk)
      end
    end

  end

end
