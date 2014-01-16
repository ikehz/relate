require 'spec_helper'

describe Organization do
  it "has a valid factory" do
    expect(Organization.make).to be_valid
  end

  it "is invalid without a title" do
    expect(Organization.make(title: nil)).not_to be_valid
  end

  it "destroys dependent memberships" do
    membership = Membership.make!
    membership.organization.destroy
    expect(Membership.where(id: membership)).not_to exist
  end
end
