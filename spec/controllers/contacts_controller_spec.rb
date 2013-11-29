require 'spec_helper'

describe ContactsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
      @contact = Contact.make!(owner: user)
      @new_contact = Contact.make(owner: user)
      @invalid_contact = Contact.new
      @unowned_contact = Contact.make!
    end

    it_behaves_like "a RESTful resource" do
      let (:resource_name) { :contact }
      let (:resource) { @contact }
      let (:new_resource) { @new_contact }
      let (:invalid_resource) { @invalid_contact }
      let (:update_attribute) { :name }
    end
  end
end
