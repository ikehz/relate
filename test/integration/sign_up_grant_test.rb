require 'test_helper'

class ContactGrantTest < ActionDispatch::IntegrationTest

  setup do
    without_grant do
      Grant::User.current_user = @u = User.make!
    end
  end

  teardown do
    without_grant do
      Grant::User.current_user = nil
    end
  end

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

end
