require 'spec_helper'

describe ParticipantsController do
  let (:user) { User.make! }
  let (:conversation) { Conversation.make!(owner: user) }

  context "when a user is signed-in" do
    before do
      sign_in user
    end

    it_behaves_like "a nested RESTful resource" do
      let (:nest_resource_name) { :conversation }
      let (:nest_resource) { conversation }
      let (:resource_name) { :participant }
      let (:resource) { Participant.make!(owner: user, conversation: conversation) }
      let (:invalid_resource) { Participant.new }
      let (:update_resource) { Participant.make(owner: user, contact: Contact.make!(owner: user)) }
      let (:update_attribute) { :contact }
    end
  end
end
