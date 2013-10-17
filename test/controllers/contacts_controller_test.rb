require 'test_helper'

class ContactsControllerTest < ActionController::TestCase

  setup do
    without_grant do
      @c = Contact.make!
    end
  end

  context "an anonymous user" do

    should "not get index" do
      get :index
      assert_redirected_to new_user_session_path
      assert_nil assigns(:contacts)
    end

    should "not get new" do
      get :new
      assert_redirected_to new_user_session_path
    end

    should "not create contact" do
      assert_no_difference('Contact.count') do
        post :create, contact: { name: @c.name, user_id: @c.user_id }
      end
      assert_redirected_to new_user_session_path
    end

    should "not show contact" do
      get :show, id: @c
      assert_redirected_to new_user_session_path
    end

    should "not get edit" do
      get :edit, id: @c
      assert_redirected_to new_user_session_path
    end

    should "not update contact" do
      patch :update, id: @c, contact: { name: @c.name, user_id: @c.user_id }
      assert_redirected_to new_user_session_path
    end

    should "not destroy contact" do
      assert_no_difference('Contact.count') do
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
      assert_not_nil assigns(:contacts)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create contact" do
      assert_difference('Contact.count') do
        post :create, contact: { name: @c.name, user_id: @u }
      end
      assert_redirected_to contact_path(assigns(:contact))
    end

    context "for a contact they own" do

      setup do
        without_grant do
          @c.update(user: @u)
        end
      end

      should "show contact" do
        get :show, id: @c
        assert_response :success
      end

      should "get edit" do
        get :edit, id: @c
        assert_response :success
      end

      should "update contact" do
        patch :update, id: @c, contact: { name: @c.name, user_id: @c.user_id }
        assert_redirected_to contact_path(assigns(:contact))
      end

      should "destroy contact" do
        assert_difference('Contact.count', -1) do
          delete :destroy, id: @c
        end
        assert_redirected_to contacts_path
      end

    end

    context "for a contact they do not own" do

      should "be forbidden to show contact" do
        get :show, id: @c
        assert_response 403
      end

      should "be forbidden to get edit" do
        get :edit, id: @c
        assert_response 403
      end

      should "be forbidden to update contact" do
        patch :update, id: @c, contact: { name: @c.name, user_id: @c.user_id }
        assert_response 403
      end

      should "be forbidden to destroy contact" do
        assert_no_difference('Contact.count', -1) do
          delete :destroy, id: @c
        end
        assert_response 403
      end

    end

  end

end
