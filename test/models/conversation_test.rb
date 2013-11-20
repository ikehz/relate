require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  include GrantTestHelpers

  context "a conversation" do

    setup do
      @c = Conversation.make!
    end

    should "be valid" do
      assert @c.valid?
    end

  end

  context "an empty conversation" do

    setup do
      @c_empty = Conversation.new
    end

    should "be invalid" do
      assert @c_empty.invalid?
      assert @c_empty.errors[:owner].any?
    end

  end

end
