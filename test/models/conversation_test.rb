require 'test_helper'

class ConversationTest < ActiveSupport::TestCase

  # security

  context "a user" do

    setup do
      without_grant do
        @u = User.make!
        Grant::User.current_user = @u
      end
    end

    context "for a conversation that is theirs" do

      setup do
        without_grant do
          @c = Conversation.make!(user: @u)
        end
      end

      should "find that conversation" do
        assert_nothing_raised { Conversation.find(@c.id) }
      end

      should "create a conversation that is theirs" do
        assert_nothing_raised { Conversation.make!(user: @u) }
      end

      should "update that conversation" do
        assert_nothing_raised { @c.save }
      end

      should "destroy that conversation" do
        assert_nothing_raised { @c.destroy }
      end

    end

    context "for a conversation that is not theirs" do

      setup do
        without_grant do
          @c = Conversation.make!
        end
      end

      should "not find that conversation" do
        assert_raises(Grant::Error) { Conversation.find(@c.id) }
      end

      should "not create a conversation that is not theirs" do
        assert_raises(Grant::Error) { Conversation.make! }
      end

      should "not update that conversation" do
        assert_raises(Grant::Error) { @c.save }
      end

      should "not destroy that conversation" do
        assert_raises(Grant::Error) { @c.destroy }
      end

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
