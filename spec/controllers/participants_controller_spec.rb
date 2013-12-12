require 'spec_helper'

describe ParticipantsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
      @conversation = Conversation.make!(owner: user)
      @participant = Participant.make!(owner: user, conversation: @conversation)
      @new_participant = Participant.make(owner: user, contact: Contact.make!(owner: user))
      @invalid_participant = Participant.new
      @unowned_participant = Participant.make!
    end

    it_behaves_like "a nested RESTful resource controller" do
      let (:nest_resource_name) { :conversation }
      let (:nest_resource) { @conversation }
      let (:resource_name) { :participant }
      let (:resource) { @participant }
      let (:new_resource) { @new_participant }
      let (:invalid_resource) { @invalid_participant }
      let (:update_attribute) { :contact }
    end

    it_behaves_like "a RESTful unowned resource controller" do
      let (:unowned_resource) { @unowned_participant }
    end
  end
end
