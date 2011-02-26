require 'spec_helper'

describe Shelltoad::Error do

  subject { Shelltoad::Error.magic_find(TEST_ERROR % 1000) }

  its(:view) { should_not be_empty }

  describe ".all" do
    it "should return the list of errors" do
      described_class.all.should_not be_empty
    end
  end

  its(:resolve!) { should be_true}

  its(:url) {should == URI.parse("http://startdatelabs.hoptoadapp.com/errors/#{TEST_ERROR}")}

  
end
