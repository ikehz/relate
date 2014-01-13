require 'spec_helper'

describe Conversation do
  it "has a valid factory" do
    expect(Conversation.make).to be_valid
  end

  it "is invalid without a description" do
    expect(Conversation.make(description: nil)).not_to be_valid
  end

  it "is invalid without a date" do
    expect(Conversation.make(date: nil)).not_to be_valid
  end

  it "destroys dependent participants" do
    participant = Participant.make!
    participant.conversation.destroy
    expect(Participant.where(id: participant)).not_to exist
  end

  it "destroys dependent conversation_tags" do
    conversation_tag = ConversationTag.make!
    conversation_tag.conversation.destroy
    expect(ConversationTag.where(id: conversation_tag)).not_to exist
  end

  it_behaves_like "an owned model"
end
