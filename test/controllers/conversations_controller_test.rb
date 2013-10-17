require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase

  setup do
    without_grant do
      @c = Conversation.make!
    end
  end

  context "an anonymous user" do

    should "not get index" do
      get :index
      assert_redirected_to new_user_session_path
      assert_nil assigns(:conversations)
    end

    should "not get new" do
      get :new
      assert_redirected_to new_user_session_path
    end

    should "not create conversation" do
      assert_no_difference('Conversation.count') do
        post :create, conversation: { notes: @c.notes, user_id: @c.user_id }
      end
      assert_redirected_to new_user_session_path
    end

    should "not show conversation" do
      get :show, id: @c
      assert_redirected_to new_user_session_path
    end

    should "not get edit" do
      get :edit, id: @c
      assert_redirected_to new_user_session_path
    end

    should "not update conversation" do
      patch :update, id: @c, conversation: { notes: @c.notes, user_id: @c.user_id }
      assert_redirected_to new_user_session_path
    end

    should "not destroy conversation" do
      assert_no_difference('Conversation.count') do
        delete :destroy, id: @c
      end
      assert_redirected_to new_user_session_path
    end

  end

  context "a signed-in user" do

    setup do
      without_grant do
        sign_in @u = User.make!
      end
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
        post :create, conversation: { notes: @c.notes, user_id: @u }
      end
      assert_redirected_to conversation_path(assigns(:conversation))
    end

    context "for a conversation they own" do

      setup do
        without_grant do
          @c.update(user: @u)
        end
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

    context "for a conversation they do not own" do

      should "be forbidden to show conversation" do
        get :show, id: @c
        assert_response 403
      end

      should "be forbidden to get edit" do
        get :edit, id: @c
        assert_response 403
      end

      should "be forbidden to update conversation" do
        patch :update, id: @c, conversation: { notes: @c.notes, user_id: @c.user_id }
        assert_response 403
      end

      should "be forbidden to destroy conversation" do
        assert_no_difference('Conversation.count', -1) do
          delete :destroy, id: @c
        end
        assert_response 403
      end

    end

  end

end
