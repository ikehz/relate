require 'spec_helper'

describe ParticipantsController do
  let (:user) { User.make! }

  context "when a user is signed-in" do
    before do
      sign_in user
      @conversation = Conversation.make!(owner: user)
      @participant = Participant.make!(owner: user, conversation: @conversation)
      @new_participant = Participant.make(owner: user, contact: Contact.make!(owner: user))
      @invalid_participant = Participant.new
      @unowned_participant = Participant.make!
    end

    context "nested GET #new" do
      it "assigns a new resource with the correct nest resource" do
        get :new, conversation_id: @conversation
        expect(assigns(:participant)).to be_new_record
        expect(assigns(:participant).conversation).to eq(@conversation)
      end

      it "responds successfully with 200" do
        get :new, conversation_id: @conversation
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the correct template" do
        get :new, conversation_id: @conversation
        expect(response).to render_template :new
      end
    end

    context "nested POST #create" do
      context "with valid attributes" do
        it "saves the new resource with correct nest resource" do
          post :create, conversation_id: @conversation, participant: @new_participant.attributes
          expect(assigns(:participant)).not_to be_new_record
          expect(assigns(:participant).conversation).to eq(@conversation)
        end

        it "redirects to nested resource with flash message" do
          post :create, conversation_id: @conversation, participant: @new_participant.attributes
          expect(response).to redirect_to(@conversation)
          expect(flash[:success]).not_to be_nil
        end
      end

      context "with invalid attributes" do
        it "does not save the new resource" do
          post :create, conversation_id: @conversation, participant: @invalid_participant.attributes
          expect(assigns(:participant)).to be_new_record
        end

        it "responds successfully with 200" do
          post :create, conversation_id: @conversation, participant: @invalid_participant.attributes
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        it "renders the :new template" do
          post :create, conversation_id: @conversation, participant: @invalid_participant.attributes
          expect(response).to render_template :new
        end
      end
    end

    context "nested DELETE #destroy" do
      it "destroys the Resource" do
        delete :destroy, id: @participant
        expect(assigns(:participant)).to be_destroyed
      end

      it "redirects to index" do
        delete :destroy, id: @participant
        expect(response).to redirect_to(@conversation)
      end
    end

    it_behaves_like "a RESTful unowned resource controller" do
      let (:unowned_resource) { @unowned_participant }
    end
  end
end
