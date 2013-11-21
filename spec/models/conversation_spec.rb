require 'spec_helper'

describe Conversation do
  it "has a valid factory" do
    expect(Conversation.make).to be_valid
  end
end
