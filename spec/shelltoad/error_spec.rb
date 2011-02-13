require 'spec_helper'

describe Shelltoad::Error do

  it "should view issue" do
    puts Shelltoad::Error.magic_find("045").view || "Not found"
  end
  
end
