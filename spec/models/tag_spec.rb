require 'spec_helper'

describe Tag do
  it "has a valid factory" do
    expect(Tag.make).to be_valid
  end

  it "is invalid without a name" do
    expect(Tag.make(name: nil)).not_to be_valid
  end
end
