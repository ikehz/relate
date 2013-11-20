require 'test_helper'

class ParticipantGrantTest < ActionDispatch::IntegrationTest

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

  context "a participant whose conversation belongs to the current user" do

    setup do
      without_grant do
        @p = Participant.make!(conversation: Conversation.make!(owner: @u))
      end
    end

    should "be found" do
      assert_nothing_raised { Participant.find(@p.id) }
    end

    should "be created" do
      assert_nothing_raised { Participant.make!(conversation: Conversation.make!(owner: @u)) }
    end

    should "be updated" do
      assert_nothing_raised { @p.save }
    end

    should "be destroyed" do
      assert_nothing_raised { @p.destroy }
    end

  end

  context "a participant whose conversation does not belong to the current user" do

    setup do
      without_grant do
        @p = Participant.make!
      end
    end

    should "not be found" do
      assert_raises(Grant::Error) { Participant.find(@p.id) }
    end

    should "not be created" do
      assert_raises(Grant::Error) { Participant.make! }
    end

    should "not be updated" do
      assert_raises(Grant::Error) { @p.save }
    end

    should "not be destroyed" do
      assert_raises(Grant::Error) { @p.destroy }
    end

  end

end
