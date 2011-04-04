require 'spec_helper'
require "fakeweb"

describe Shelltoad do

  before(:each) do
    Shelltoad::Configuration.stubs(:key).returns("whatever")
    Shelltoad::Configuration.stubs(:project).returns("startdatelabs")
    Shelltoad::Error.any_instance.stubs(:commit).returns(true)
  end

  describe ".run" do
    [["error", TEST_ERROR], "errors", ["commit", TEST_ERROR], ["resolve", TEST_ERROR]].each do |command|
      describe "command:#{command.inspect}" do
        subject { Shelltoad.run(*Array(command)) }
        it { should == 0 }
      end
    end

    context "when hoptoad service is unavailable" do
      before(:each) do
        FakeWeb.register_uri(
          :any, 
          %r|http://startdatelabs.hoptoadapp.com/errors.xml|,
          :body => "Service Unavailable. Try again later",
          :status => 500
        )
        Shelltoad.run("errors")


      end

      it "should output the server error" do
        TESTOUT.should =~ /^Hoptoad service not available./
      end
    end
  end

end
