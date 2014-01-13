require 'spec_helper'

describe Tag do
  it "has a valid factory" do
    expect(Tag.make).to be_valid
  end

  it "is invalid without a name" do
    expect(Tag.make(name: nil)).not_to be_valid
  end

  it "is invalid with a duplicate name for a given owner" do
    t = Tag.make!
    expect(Tag.make(name: t.name, owner: t.owner)).not_to be_valid
  end

  it "destroys dependent conversation_tags" do
    conversation_tag = ConversationTag.make!
    conversation_tag.tag.destroy
    expect(ConversationTag.where(id: conversation_tag)).not_to exist
  end

  it_behaves_like "an owned model"
end
