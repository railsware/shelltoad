require 'spec_helper'
require "fakeweb"

describe Shelltoad do

  before(:each) do
    Shelltoad::Configuration.stubs(:key).returns(123)
    Shelltoad::Configuration.stubs(:project).returns("startdatelabs")
    FakeWeb.register_uri("http://startdatelabs.hoptoadapp.com/errors.xml", :body => <<-XML)
<?xml version="1.0" encoding="UTF-8"?> 
<groups type="array"> 
  <group> 
    <created-at type="datetime">2011-01-14T09:30:17Z</created-at> 
    <notice-hash>2bbb45ad61b397a62053bd0562f63ceb</notice-hash> 
    <project-id type="integer">14951</project-id> 
    <updated-at type="datetime">2011-01-28T01:51:53Z</updated-at> 
    <action nil="true"></action> 
    <resolved type="boolean">false</resolved> 
    <error-class>Net::SMTPSyntaxError</error-class> 
    <error-message>Net::SMTPSyntaxError: 501 Syntax error </error-message> 
    <id type="integer">3750506</id> 
    <lighthouse-ticket-id type="integer" nil="true"></lighthouse-ticket-id> 
    <controller>domU-12-31-39-15-22-AC:14588:critical,medium,low</controller> 
    <file>/var/data/www/apps/startwire/shared/bundle/ruby/1.8/gems/tlsmail-0.0.1/lib/net/smtp.rb</file> 
    <rails-env>production</rails-env> 
    <line-number type="integer">787</line-number> 
    <most-recent-notice-at type="datetime">2011-01-28T01:51:52Z</most-recent-notice-at> 
    <notices-count type="integer">21</notices-count> 
  </group> 
</groups> 
XML
    FakeWeb.register_uri("http://startdatelabs.hoptoadapp.com/errors/123.xml")
  end

  describe ".run" do
    [["error", 123], "errors", "commit", 123].each do |command|
      describe "#{command}" do
        subject { Shelltoad.run(Array(command)) }
        it { should_not be_nil }
      end
    end
  end

end
