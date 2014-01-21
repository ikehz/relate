require 'spec_helper'

describe Membership do
  it "has a valid factory" do
    expect(Membership.make).to be_valid
  end

  it "is invalid if it is a duplicate" do
    m = Membership.make!
    expect(Membership.make(user: m.user, organization: m.organization)).not_to be_valid
  end
    
  it "is invalid without a user" do
    expect(Membership.make(user: nil)).not_to be_valid
  end

  it "is invalid without a organization" do
    expect(Membership.make(organization: nil)).not_to be_valid
  end

  describe "#user_username" do
    it "returns the user's username" do
      u = User.make
      expect(Membership.make(user: u).user_username).to eq(u.username)
    end
  end
end
