require 'spec_helper'

describe ContactsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
    end

    it_behaves_like "a RESTful resource" do
      let (:resource_name) { :contact }
      let (:resource) { Contact.make!(owner: user) }
      let (:invalid_resource) { Contact.new }
      let (:update_resource) { Contact.make(owner: user) }
      let (:update_attribute) { :name }
    end
  end
end
