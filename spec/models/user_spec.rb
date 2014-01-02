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
end
