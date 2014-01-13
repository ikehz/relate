require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(User.make).to be_valid
  end

  it "is invalid without a username" do
    expect(User.make(username: nil)).not_to be_valid
  end

  it "is invalid with a duplicate username" do
    u = User.make!
    expect(User.make(username: u.username)).not_to be_valid
  end

  it "is invalid with an invalid username" do
    ['u ', '\u', 'u@u', ' ', 'U-', "u\n"].each do |username|
      expect(User.make(username: username)).not_to be_valid
    end
  end

  it "is valid with a valid username" do
    ['u_', 'u-'].each do |username|
      expect(User.make(username: username)).to be_valid
    end
  end

  it "is invalid without a password" do
    expect(User.make(password: nil)).not_to be_valid
  end

  it "is invalid without an email" do
    expect(User.make(email: nil)).not_to be_valid
  end

  it "is invalid with a duplicate email" do
    u = User.make!
    expect(User.make(email: u.email)).not_to be_valid
  end

  it "is valid without a name" do
    expect(User.make(name: nil)).to be_valid
  end

  it "destroys dependent contacts" do
    contact = Contact.make!
    contact.owner.destroy
    expect(Contact.where(id: contact)).not_to exist
  end

  it "destroys dependent conversations" do
    conversation = Conversation.make!
    conversation.owner.destroy
    expect(Conversation.where(id: conversation)).not_to exist
  end

  it "destroys dependent participants" do
    participant = Participant.make!
    participant.owner.destroy
    expect(Participant.where(id: participant)).not_to exist
  end

  it "destroys dependent tags" do
    tag = Tag.make!
    tag.owner.destroy
    expect(Tag.where(id: tag)).not_to exist
  end

  it "destroys dependent conversation_tags" do
    conversation_tag = ConversationTag.make!
    conversation_tag.owner.destroy
    expect(ConversationTag.where(id: conversation_tag)).not_to exist
  end
end
