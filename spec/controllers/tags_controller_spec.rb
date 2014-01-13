require 'spec_helper'

describe TagsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
      @tag = Tag.make!(owner: user)
      @new_tag = Tag.make(owner: user)
      @invalid_tag = Tag.new
      @unowned_tag = Tag.make!
    end

    it_behaves_like "a RESTful resource controller" do
      let (:resource_name) { :tag }
      let (:resource) { @tag }
      let (:new_resource) { @new_tag }
      let (:invalid_resource) { @invalid_tag }
      let (:update_attribute) { :name }
    end

    it_behaves_like "a RESTful unowned resource controller" do
      let (:unowned_resource) { @unowned_tag }
    end
  end
end
