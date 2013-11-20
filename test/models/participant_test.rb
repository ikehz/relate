require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  include GrantTestHelpers

  context "a participant" do

    setup do
      @p = Participant.make!
    end

    should "be valid" do
      assert @p.valid?
    end

    context "that is a duplicate of another contact" do

      setup do
        @p_dup = Participant.new(contact: @p.contact, conversation: @p.conversation)
      end

      should "be invalid" do
        assert @p_dup.invalid?
        assert @p_dup.errors[:conversation].any?
      end

    end

    context "whose contact has a different owner than its conversation" do

      setup do
        @p.contact = Contact.make!
      end

      should "be invalid" do
        assert @p.invalid?
        assert @p.errors[:contact].any?
      end

    end

  end

  context "an empty participant" do

    setup do
      @p_empty = Participant.new
    end

    should "be invalid" do
      assert @p_empty.invalid?
      assert @p_empty.errors[:contact].any?
      assert @p_empty.errors[:conversation].any?
    end

  end

end
