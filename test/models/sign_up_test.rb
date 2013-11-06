require 'test_helper'

class SignUpTest < ActiveSupport::TestCase

  # security

  context "a sign_up" do

    setup do
      without_grant do
        @s = SignUp.make!
      end
    end

    should "not be found" do
      assert_raises(Grant::Error) { SignUp.find(@s.id) }
    end

    should "be created" do
      assert_nothing_raised do
        # XXX we can't use SignUp.make! here because it tries to reload the
        # record, which is currently not permitted
        #
        # SignUp.make!
        SignUp.make.save!
      end
    end

    should "not be updated" do
      assert_raises(Grant::Error) { @s.save }
    end

    should "not be destroyed" do
      assert_raises(Grant::Error) { @s.destroy }
    end

  end

  # validations

  context "a sign_up" do

    setup do
      without_grant do
        @s = SignUp.make!
      end
    end

    should "be valid" do
      assert @s.valid?
    end

    context "with a valid email" do
      should "be valid" do
        ['s_s@s.com', 's-s@s.co.uk'].each do |email|
          @s.email = email
          assert @s.valid?, "#{email} should be a valid email"
        end
      end
    end

    context "with an invalid email" do
      should "be invalid" do
        ['s s@s.com', 's@s s.com', 's@s', '@s.com', 's', "s\n"].each do |email|
          @s.email = email
          assert @s.invalid?, "#{email} should be an invalid email"
          assert @s.errors[:email].any?, "#{email} should be an invalid email"
        end
      end
    end

    context "with a duplicate email" do
      should "be invalid" do
        @t = SignUp.make(email: @s.email)
        assert @t.invalid?, "#{@t.email} should be a duplicate, and therefore invalid, email"
        assert @t.errors[:email].any?, "#{@t.email} should be a duplicate, invalid email"
      end
    end

  end

  context "a sign_up that is empty" do

    setup do
      without_grant do
        @s_empty = SignUp.new
      end
    end

    should "be invalid" do
      assert @s_empty.invalid?
      assert @s_empty.errors[:email].any?
      assert @s_empty.errors[:build].any?
      assert @s_empty.errors[:mobilize].any?
      assert @s_empty.errors[:share].any?
    end

  end

end
