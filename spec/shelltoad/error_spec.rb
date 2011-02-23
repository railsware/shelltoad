require 'spec_helper'

describe Shelltoad::Error do

  it "should view issue" do
    Shelltoad.output(Shelltoad::Error.magic_find(TEST_ERROR).view)
  end
  
end
