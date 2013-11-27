require 'spec_helper'

describe Participant do
  it "has a valid factory" do
    expect(Participant.make).to be_valid
  end

  it "is invalid if it is a duplicate" do
    p = Participant.make!
    expect(Participant.make(owner: p.owner, contact: p.contact, conversation: p.conversation)).not_to be_valid
  end
    
  it "is invalid if its contact has a different owner" do
    expect(Participant.make(contact: Contact.make)).not_to be_valid
  end

  it "is invalid if its conversation has a different owner" do
    expect(Participant.make(conversation: Conversation.make)).not_to be_valid
  end

  it "is invalid without a contact" do
    expect(Participant.make(contact: nil)).not_to be_valid
  end

  it "is invalid without a conversation" do
    expect(Participant.make(conversation: nil)).not_to be_valid
  end

  describe "#contact_name" do
    it "returns the contact's name" do
      c = Contact.make
      expect(Participant.make(contact: c).contact_name).to eq(c.name)
    end
  end
end
