require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase

  setup do
    without_grant do
      @p = Participant.make!
      @cv = @p.conversation
      @ct = @p.contact
    end
  end

  context "an anonymous user" do

    # shallow nest

    should "not get index" do
      get :index, conversation_id: @cv.id
      assert_redirected_to new_user_session_path
      assert_nil assigns(:participants)
    end

    should "not get new" do
      get :new, conversation_id: @cv.id
      assert_redirected_to new_user_session_path
    end

    should "not create participant" do
      assert_no_difference('Participant.count') do
        post :create, participant: { contact: @ct }, conversation_id: @cv.id
      end
      assert_redirected_to new_user_session_path
    end

    # not shallow nest

    should "not show participant" do
      get :show, id: @p
      assert_redirected_to new_user_session_path
    end

    should "not get edit" do
      get :edit, id: @p
      assert_redirected_to new_user_session_path
    end

    should "not update participant" do
      patch :update, id: @p, participant: { conversation: @cv, contact: @ct }
      assert_redirected_to new_user_session_path
    end

    should "not destroy participant" do
      assert_no_difference('Participant.count') do
        delete :destroy, id: @p
      end
      assert_redirected_to new_user_session_path
    end

  end

#  context "a signed-in user" do
#
#    setup do
#      without_grant do
#        sign_in @u = User.make!
#      end
#    end
#
#    should "get index" do
#      get :index, conversation_id: @cv.id
#      assert_response :success
#      assert_not_nil assigns(:participants)
#    end
#
#    should "get new" do
#      get :new, conversation_id: @cv.id
#      assert_response :success
#    end
#
#    should "create participant" do
#      assert_difference('Participant.count') do
#        post :create, participant: { contact: @ct }, conversation_id: @cv.id
#      end
#      assert_redirected_to participant_path(assigns(:participant))
#    end
#
#    context "for a participant they own" do
#
#      setup do
#        without_grant do
#          @cv.update(owner: @u)
#          @ct.update(owner: @u)
#        end
#      end
#
#      should "show participant" do
#        get :show, id: @p
#        assert_response :success
#      end
#
#      should "get edit" do
#        get :edit, id: @p
#        assert_response :success
#      end
#
#      should "update participant" do
#        patch :update, id: @p, participant: { conversation: @cv, contact: @ct }
#        assert_redirected_to participant_path(assigns(:participant))
#      end
#
#      should "destroy participant" do
#        assert_difference('Participant.count', -1) do
#          delete :destroy, id: @p
#        end
#        assert_redirected_to conversation_participants_path(@cv)
#      end
#
#    end
#
#    context "for a participant they do not own" do
#
#      should "be forbidden to show participant" do
#        get :show, id: @p
#        assert_response 403
#      end
#
#      should "be forbidden to get edit" do
#        get :edit, id: @p
#        assert_response 403
#      end
#
#      should "be forbidden to update participant" do
#        patch :update, id: @p, participant: { date: @p.date, notes: @p.notes }
#        assert_response 403
#      end
#
#      should "be forbidden to destroy participant" do
#        assert_no_difference('Participant.count', -1) do
#          delete :destroy, id: @p
#        end
#        assert_response 403
#      end
#
#    end

  end

end
