require 'spec_helper'
require "fakeweb"

describe Shelltoad do

  before(:each) do
    Shelltoad::Error.any_instance.stubs(:commit).returns(true)
  end

  describe ".run" do
    subject { Shelltoad.run(*args) }


    [["error", TEST_ERROR], "errors",  ["resolve", TEST_ERROR]].each do |command|
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

    describe "commit command" do
      subject { Shelltoad.run("commit", TEST_ERROR, *_args) }
      before(:each) do
        Shelltoad::Command.stubs(:changes_staged?).returns(_staged)
      end
      
      let(:_staged) { true }
      let(:_args) { [] }
      it { should == 0 }
      
      context "when no changes staged in git" do
        let(:_staged) { false }
        it { should == 1 }
      end

      context "when -m argument specified" do
        let(:_args) { ["-m", "My commit"]}
        it {should == 0}
      end

    end
  end

end
