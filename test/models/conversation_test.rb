require 'test_helper'

class ConversationTest < ActiveSupport::TestCase

  # security

  context "a user" do

    setup do
      without_grant do
        @u = User.make!
        @c_u = Conversation.make!(user: @u)
        @v = User.make!
        @c_v = Conversation.make!(user: @v)
        Grant::User.current_user = @u
      end
    end

    should "find a conversation that is theirs" do
      assert_nothing_raised { Conversation.find(@c_u.id) }
    end

    should "not find a conversation that is not theirs" do
      assert_raises(Grant::Error) { Conversation.find(@c_v.id) }
    end

    should "create a conversation that is theirs" do
      assert_nothing_raised { Conversation.make!(user: @u) }
    end

    should "not create a conversation that is not theirs" do
      assert_raises(Grant::Error) { Conversation.make!(user: @v) }
    end

    should "update a conversation that is theirs" do
      assert_nothing_raised { @c_u.save }
    end

    should "not update a conversation that is not theirs" do
      assert_raises(Grant::Error) { @c_v.save }
    end

    should "destroy a conversation that is theirs" do
      assert_nothing_raised { @c_u.destroy }
    end

    should "not destroy a conversation that is not theirs" do
      assert_raises(Grant::Error) { @c_v.destroy }
    end

  end

  # validations

  context "a conversation" do

    setup do
      without_grant do
        @c = Conversation.make!
      end
    end

    context "that is valid" do
      should "be valid" do
        assert @c.valid?
      end
    end

    context "that is empty" do
      setup do
        @c_empty = Conversation.new
      end
      should "be invalid" do
        assert @c_empty.invalid?
        assert @c_empty.errors[:user].any?
      end
    end

  end

end
