require 'spec_helper'

describe Conversation do
  it "has a valid factory" do
    expect(Conversation.make).to be_valid
  end

  it_behaves_like "an owned model"
end
