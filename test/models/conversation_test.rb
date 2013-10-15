require 'test_helper'

class ConversationTest < ActiveSupport::TestCase

  context "a conversation" do

    setup do
      @c = Conversation.make!
    end

    context "that is valid" do
      should "be valid" do
        assert @c.valid?
      end
    end

    context "that is empty" do
      should "be invalid" do
        c = Conversation.new
        assert c.invalid?
        assert c.errors[:user].any?
      end
    end

  end

end
