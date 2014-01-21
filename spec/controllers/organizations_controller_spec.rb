require 'spec_helper'

describe OrganizationsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
      @organization = Organization.make!()
      @organization.users << user
      @new_organization = Organization.make()
      @new_organization.users << user
      @invalid_organization = Organization.new
      @unowned_organization = Organization.make!
    end

    it_behaves_like "a RESTful resource controller" do
      let (:resource_name) { :organization }
      let (:resource) { @organization }
      let (:new_resource) { @new_organization }
      let (:invalid_resource) { @invalid_organization }
      let (:update_attribute) { :title }
    end

    it_behaves_like "a RESTful unowned resource controller" do
      let (:unowned_resource) { @unowned_organization }
    end
  end
end
