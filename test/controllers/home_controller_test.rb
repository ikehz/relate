require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  context "an anonymous user" do

    should "get index" do
      get :index
      assert_response :success
    end

  end

  context "a signed-in user" do

    setup do
      sign_in @u = User.make!
    end

    should "get index" do
      get :index
      assert_response :success
    end

  end

end
