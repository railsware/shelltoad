require 'spec_helper'
require "fakeweb"

describe Shelltoad do

  before(:each) do
    Shelltoad::Configuration.stubs(:key).returns("whatever")
    Shelltoad::Configuration.stubs(:account).returns("startdatelabs")
    Shelltoad::Configuration.stubs(:project_id).returns(14951)
    Shelltoad::Error.any_instance.stubs(:commit).returns(true)
  end

  describe ".run" do
    [["error", TEST_ERROR], "errors", ["commit", TEST_ERROR], ["resolve", TEST_ERROR]].each do |command|
      describe "command:#{command.inspect}" do
        subject { Shelltoad.run(*Array(command)) }
        it { should == 0 }
      end
    end

  end

end
