require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    expect(Contact.make).to be_valid
  end

  it "is invalid without a name" do
    expect(Contact.make(name: nil)).not_to be_valid
  end

  it "destroys dependent participants" do
    participant = Participant.make!
    participant.contact.destroy
    expect(Participant.where(id: participant)).not_to exist
  end

  it_behaves_like "an owned model"
end
