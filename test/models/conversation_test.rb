require 'test_helper'

class ConversationTest < ActiveSupport::TestCase

  setup do
    without_grant do
      Grant::User.current_user = @u = User.make!
    end
  end

  # security

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

  # validations

  context "a conversation that belongs to the current user" do

    setup do
      without_grant do
        @c = Conversation.make!(owner: @u)
      end
    end

    should "be valid" do
      assert @c.valid?
    end

  end

  context "a conversation that is empty" do

    setup do
      without_grant do
        @c_empty = Conversation.new
      end
    end

    should "be invalid" do
      assert @c_empty.invalid?
      assert @c_empty.errors[:owner].any?
    end

  end

end
