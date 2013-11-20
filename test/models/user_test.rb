require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include GrantTestHelpers

  context "a user" do

    setup do
      @u = User.make!
    end

    should "be valid" do
      assert @u.valid?
    end

    context "with a valid username" do
      should "be valid" do
        ['u_', 'u-'].each do |username|
          @u.username = username
          assert @u.valid?, "#{username} should be a valid username"
        end
      end
    end

    context "with an invalid username" do
      should "be invalid" do
        ['u ', '\u', 'u@u', ' ', 'U-', "u\n"].each do |username|
          @u.username = username
          assert @u.invalid?, "#{username} should be an invalid username"
          assert @u.errors[:username].any?, "#{username} should be an invalid username"
        end
      end
    end

    context "with a duplicate username" do
      should "be invalid" do
        v = User.make username: @u.username
        assert v.invalid?, "#{v.username} should be a duplicate, and therefore invalid, username"
        assert v.errors[:username].any?, "#{v.username} should be a duplicate, invalid username"
      end
    end

  end

  context "an empty user" do

    setup do
      @u = User.new
    end

    should "be invalid" do
      assert @u.invalid?
      assert @u.errors[:username].any?
      assert @u.errors[:password].any?
      assert @u.errors[:email].any?
    end

  end

end
