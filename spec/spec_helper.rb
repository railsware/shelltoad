require 'rubygems'
require "net/http"
require 'spec'
require 'spec/autorun'
require "mocha"
require 'active_record'
require "fakeweb"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'..','lib'))
require "shelltoad"

TEST_ERROR = 4040123

Spec::Runner.configure do |config|
end

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(
  :any, 
  %r|http://startdatelabs.hoptoadapp.com/errors.xml|,
  :body => File.new("spec/assets/errors.xml").read
)
FakeWeb.register_uri(
  :any, 
  %r|http://startdatelabs.hoptoadapp.com/errors/#{TEST_ERROR}.xml|,
  :body => File.new("spec/assets/error.xml").read
)

Shelltoad.const_set("STDOUT", "")



class Net::HTTP

  alias_method :request_without_log,  :request

  def request(request, body = nil, &block)
    url = "http#{"s" if self.use_ssl?}://#{self.address}:#{self.port}#{request.path}"
    rails_log("HTTP #{request.method}", url)
    rails_log("POST params", request.body) if request.is_a?(::Net::HTTP::Post)
    res = request_without_log(request, body, &block)
    rails_log("Response body", res.body) if res
    res
  end

  def rails_log(message, dump)
    if started? && defined?(Rails)
      Rails.logger.debug(format_log_entry(message, dump))
    end
  end

  def format_log_entry(message, dump = nil)
    if ActiveRecord::Base.colorize_logging
      message_color, dump_color = "4;32;1", "0;1"
      log_entry = "  \e[#{message_color}m#{message}\e[0m   "
      log_entry << "\e[#{dump_color}m%#{String === dump ? 's' : 'p'}\e[0m" % dump if dump
      log_entry
    else
      "%s  %s" % [message, dump]
    end
  end

end

