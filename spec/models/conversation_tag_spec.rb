require 'spec_helper'

describe ConversationTag do
  it "has a valid factory" do
    expect(ConversationTag.make).to be_valid
  end

  it "is invalid if it is a duplicate" do
    p = ConversationTag.make!
    expect(ConversationTag.make(owner: p.owner, tag: p.tag, conversation: p.conversation)).not_to be_valid
  end
    
  it "is invalid if its tag has a different owner" do
    expect(ConversationTag.make(tag: Tag.make)).not_to be_valid
  end

  it "is invalid if its conversation has a different owner" do
    expect(ConversationTag.make(conversation: Conversation.make)).not_to be_valid
  end

  it "is invalid without a tag" do
    expect(ConversationTag.make(tag: nil)).not_to be_valid
  end

  it "is invalid without a conversation" do
    expect(ConversationTag.make(conversation: nil)).not_to be_valid
  end

  describe "#tag_name" do
    it "returns the tag's name" do
      t = Tag.make
      expect(ConversationTag.make(tag: t).tag_name).to eq(t.name)
    end
  end

  it_behaves_like "an owned model"
end
