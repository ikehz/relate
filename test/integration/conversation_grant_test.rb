require 'test_helper'

class ConversationGrantTest < ActionDispatch::IntegrationTest

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

  context "a conversation that belongs to the current user" do

    setup do
      without_grant do
        @c = Conversation.make!(owner: @u)
      end
    end

    should "be found" do
      assert_nothing_raised { Conversation.find(@c.id) }
    end

    should "be created" do
      assert_nothing_raised { Conversation.make!(owner: @u) }
    end

    should "be updated" do
      assert_nothing_raised { @c.save }
    end

    should "be destroyed" do
      assert_nothing_raised { @c.destroy }
    end

  end

  context "a conversation that does not belong to the current user" do

    setup do
      without_grant do
        @c = Conversation.make!
      end
    end

    should "not be found" do
      assert_raises(Grant::Error) { Conversation.find(@c.id) }
    end

    should "not be created" do
      assert_raises(Grant::Error) { Conversation.make! }
    end

    should "not be updated" do
      assert_raises(Grant::Error) { @c.save }
    end

    should "not be destroyed" do
      assert_raises(Grant::Error) { @c.destroy }
    end

  end

end
