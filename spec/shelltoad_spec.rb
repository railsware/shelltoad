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
    subject { Shelltoad.run(*args) }


    [["error", TEST_ERROR], "errors", ["commit", TEST_ERROR], ["resolve", TEST_ERROR]].each do |command|
      describe "command:#{command.inspect}" do
        let(:args) {  Array(command) }
        it { should == 0 }
      end
    end


    describe "open command" do
      let(:args) { ["open", TEST_ERROR] }
      before(:each) do
        Shelltoad::Configuration.stubs(:browser).returns("true")
      end
      it {should  == 0}
      
    end

    describe "help commad" do
      let(:args) { "help" }
      it {should == 0}
    end
  end

end
