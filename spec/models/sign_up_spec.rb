require 'spec_helper'

describe SignUp do
  it "has a valid factory" do
    expect(SignUp.make).to be_valid
  end

  it "is invalid without an email" do
    expect(SignUp.make(email: nil)).not_to be_valid
  end

  it "is invalid with a duplicate email" do
    without_grant do
      s = SignUp.make!
      expect(SignUp.make(email: s.email)).not_to be_valid
    end
  end

  it "is invalid with an invalid email" do
    ['s s@s.com', 's@s s.com', 's@s', '@s.com', 's', "s\n"].each do |email|
      expect(SignUp.make(email: email)).not_to be_valid
    end
  end

  it "is valid with a valid email" do
    ['s_s@s.com', 's-s@s.co.uk'].each do |email|
      expect(SignUp.make(email: email)).to be_valid
    end
  end

  it "is invalid without an build" do
    expect(SignUp.make(build: nil)).not_to be_valid
  end

  it "is invalid without an mobilize" do
    expect(SignUp.make(mobilize: nil)).not_to be_valid
  end

  it "is invalid without an share" do
    expect(SignUp.make(share: nil)).not_to be_valid
  end
end
