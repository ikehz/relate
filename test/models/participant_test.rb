require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase

  setup do
    without_grant do
      Grant::User.current_user = @u = User.make!
    end
  end

  # security

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

  # validations

  context "a participant whose conversation belongs to the current user" do

    setup do
      without_grant do
        @p = Participant.make!(conversation: Conversation.make!(owner: @u))
      end
    end

    should "be valid" do
      assert @p.valid?
    end

    context "that is a duplicate of another contact" do

      setup do
        without_grant do
          @p_dup = Participant.new(contact: @p.contact, conversation: @p.conversation)
        end
      end

      should "be invalid" do
        assert @p_dup.invalid?
        assert @p_dup.errors[:conversation].any?
      end

    end

    context "but whose contact is different" do

      setup do
        without_grant do
          @p.contact = Contact.make!
        end
      end

      should "be invalid" do
        assert @p.invalid?
        assert @p.errors[:contact].any?
      end

    end

  end

  context "a participant that is empty" do

    setup do
      without_grant do
        @p_empty = Participant.new
      end
    end

    should "be invalid" do
      assert @p_empty.invalid?
      assert @p_empty.errors[:contact].any?
      assert @p_empty.errors[:conversation].any?
    end

  end

end
