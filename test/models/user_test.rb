require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "a user" do

    setup do
      @u = User.make!
    end

    context "that is valid" do
      should "be valid" do
        assert @u.valid?
      end
    end

    context "that is empty" do
      should "be invalid" do
        u = User.new
        assert u.invalid?
        assert u.errors[:username].any?
        assert u.errors[:password].any?
        assert u.errors[:email].any?
      end
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

    context "with a valid name" do
      should "be valid" do
        ['User User', 'UserUser', ''].each do |name|
          @u.name = name
          assert @u.valid?, "#{name} should be a valid name"
        end
      end
    end

    context "with an invalid name" do
      should "be invalid" do
        ['\u', 'u@u', 'U-', "u\n"].each do |name|
          @u.name = name
          assert @u.invalid?, "#{name} should be an invalid name"
          assert @u.errors[:name].any?, "#{name} should be an invalid name"
        end
      end
    end

  end

end
