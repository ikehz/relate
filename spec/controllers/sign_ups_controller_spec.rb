require 'spec_helper'

describe SignUpsController do
  describe "GET #new" do
    it "assigns a new SignUp to @sign_up" do
      get :new
      expect(assigns(:sign_up)).to be_new_record
    end

    it "responds successfully with 200" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new SignUp" do
        post :create, sign_up: SignUp.make.attributes
        expect(assigns(:sign_up)).not_to be_new_record
      end

      it "redirects to root with flash message" do
        post :create, sign_up: SignUp.make.attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).not_to be_nil
      end
    end

    context "with invalid attributes" do
      it "does not save the new SignUp" do
        post :create, sign_up: SignUp.new.attributes
        expect(assigns(:sign_up)).to be_new_record
      end

      it "responds successfully with 200" do
        post :create, sign_up: SignUp.new.attributes
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the :new template" do
        post :create, sign_up: SignUp.new.attributes
        expect(response).to render_template :new
      end
    end
  end
end
