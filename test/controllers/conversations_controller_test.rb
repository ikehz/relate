require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase

  setup do
      @c = Conversation.make!
  end

  context "an anonymous user" do

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:conversations)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create conversation" do
      assert_difference('Conversation.count') do
        post :create, conversation: { notes: @c.notes, user_id: @c.user_id }
      end

      assert_redirected_to conversation_path(assigns(:conversation))
    end

    should "show conversation" do
      get :show, id: @c
      assert_response :success
    end

    should "get edit" do
      get :edit, id: @c
      assert_response :success
    end

    should "update conversation" do
      patch :update, id: @c, conversation: { notes: @c.notes, user_id: @c.user_id }
      assert_redirected_to conversation_path(assigns(:conversation))
    end

    should "destroy conversation" do
      assert_difference('Conversation.count', -1) do
        delete :destroy, id: @c
      end

      assert_redirected_to conversations_path
    end

  end

  context "a signed-in user" do

    setup do
      sign_in @u = User.make!
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:conversations)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create conversation" do
      assert_difference('Conversation.count') do
        post :create, conversation: { notes: @c.notes, user_id: @c.user_id }
      end

      assert_redirected_to conversation_path(assigns(:conversation))
    end

    should "show conversation" do
      get :show, id: @c
      assert_response :success
    end

    should "get edit" do
      get :edit, id: @c
      assert_response :success
    end

    should "update conversation" do
      patch :update, id: @c, conversation: { notes: @c.notes, user_id: @c.user_id }
      assert_redirected_to conversation_path(assigns(:conversation))
    end

    should "destroy conversation" do
      assert_difference('Conversation.count', -1) do
        delete :destroy, id: @c
      end

      assert_redirected_to conversations_path
    end

  end

end
