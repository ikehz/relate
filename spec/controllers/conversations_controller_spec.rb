require 'spec_helper'

describe ConversationsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
    end

    it_behaves_like "a RESTful resource" do
      let (:resource_name) { :conversation }
      let (:resource) { Conversation.make!(owner: user) }
      let (:invalid_resource) { Conversation.new }
      let (:update_resource) { Conversation.make(owner: user) }
      let (:update_attribute) { :notes }
    end
  end
end
