require 'test_helper'

class SignUpsControllerTest < ActionController::TestCase

  setup do
    without_grant do
      @s = SignUp.make!
    end
  end

  context "an anonymous user" do

    # should "not get index" do
    #   get :index
    #   assert_redirected_to new_user_session_path
    #   assert_nil assigns(:sign_ups)
    # end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create sign_up" do
      assert_no_difference('SignUp.count') do
        post :create, sign_up: { email: @s.email, build: @s.build, mobilize: @s.mobilize,  share: @s.share }
      end
      assert_response :success
    end

    # should "not show sign_up" do
    #   get :show, id: @s
    #   assert_redirected_to new_user_session_path
    # end

    # should "not get edit" do
    #   get :edit, id: @s
    #   assert_redirected_to new_user_session_path
    # end

    # should "not update sign_up" do
    #   patch :update, id: @s, sign_up: { date: @s.date, notes: @s.notes }
    #   assert_redirected_to new_user_session_path
    # end

    # should "not destroy sign_up" do
    #   assert_no_difference('SignUp.count') do
    #     delete :destroy, id: @s
    #   end
    #   assert_redirected_to new_user_session_path
    # end

  end

end
