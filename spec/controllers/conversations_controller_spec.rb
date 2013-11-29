require 'spec_helper'

describe ConversationsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
      @conversation = Conversation.make!(owner: user)
      @new_conversation = Conversation.make(owner: user)
      @invalid_conversation = Conversation.new
      @unowned_conversation = Conversation.make!
    end

    it_behaves_like "a RESTful resource controller" do
      let (:resource_name) { :conversation }
      let (:resource) { @conversation }
      let (:new_resource) { @new_conversation }
      let (:invalid_resource) { @invalid_conversation }
      let (:update_attribute) { :notes }
    end

    it_behaves_like "a RESTful unowned resource controller" do
      let (:unowned_resource) { @unowned_conversation }
    end
  end
end
