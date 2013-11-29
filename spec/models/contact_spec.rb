require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    expect(Contact.make).to be_valid
  end

  it "is invalid without a name" do
    expect(Contact.make(name: nil)).not_to be_valid
  end

  it_behaves_like "an owned model"
end
