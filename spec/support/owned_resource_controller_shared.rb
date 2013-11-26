shared_examples "an owned resource controller" do
  let (:resources) { resource.to_s.pluralize.to_sym }
  let (:resource_class) { eval(resource.to_s.capitalize) }

  let (:user) { User.make! }
  let (:record) { resource_class.make!(owner: user) }
  let (:other_record) { resource_class.make! }

  let (:resources_path) { eval(resource.to_s.pluralize + '_path') }

  context "when a user is signed-in" do
    before do
      sign_in user
    end

    describe "GET #index" do
      it "assigns the user's resources to @resources" do
        get :index
        expect(assigns(resources)).to eq([record])
      end

      it "responds successfully with 200" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      it "assigns a new Resource to @resource" do
        get :new
        expect(assigns(resource)).to be_new_record
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
        it "saves the new Resource" do
          post :create, resource => resource_class.make.attributes
          expect(assigns(resource)).not_to be_new_record
        end

        it "saves the Resource with the proper owner" do
          post :create, resource => resource_class.make.attributes
          expect(assigns(resource).owner).to eq(user)
        end

        it "redirects to resource with flash message" do
          post :create, resource => resource_class.make.attributes
          expect(response).to redirect_to(assigns(resource))
          expect(flash[:success]).not_to be_nil
        end
      end

      context "with invalid attributes" do
        it "does not save the new Resource" do
          post :create, resource => resource_class.new.attributes
          expect(assigns(resource)).to be_new_record
        end

        it "responds successfully with 200" do
          post :create, resource => resource_class.new.attributes
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        it "renders the :new template" do
          post :create, resource => resource_class.new.attributes
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #show" do
      it "assigns the correct Resource to @resource" do
        get :show, id: record.id
        expect(assigns(resource)).to eq(record)
      end

      it "responds successfully with 200" do
        get :show, id: record.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the :show template" do
        get :show, id: record.id
        expect(response).to render_template :show
      end
    end

    describe "GET #edit" do
      it "assigns the correct Resource to @resource" do
        get :edit, id: record.id
        expect(assigns(resource)).to eq(record)
      end

      it "responds successfully with 200" do
        get :edit, id: record.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the :edit template" do
        get :edit, id: record.id
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates the Resource" do
          patch :update, id: record.id, resource => other_record.attributes
          expect(record.reload.send(updatable_attribute)).to eq(other_record.send(updatable_attribute))
        end

        it "saves the Resource with the proper owner" do
          patch :update, id: record.id, resource => resource_class.make.attributes
          expect(assigns(resource).owner).to eq(user)
        end

        it "redirects to resource" do
          patch :update, id: record.id, resource => resource_class.make.attributes
          expect(response).to redirect_to(assigns(resource))
        end
      end

      context "with invalid attributes" do
        it "does not update the Resource" do
          patch :update, id: record.id, resource => other_record.attributes
          expect(record.reload.send(updatable_attribute)).to eq(record.send(updatable_attribute))
        end

        it "renders the :edit template" do
          patch :update, id: record.id, resource => resource_class.new.attributes
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the Resource" do
        delete :destroy, id: record.id
        expect(assigns(resource)).to be_destroyed
      end

      it "redirects to index" do
        delete :destroy, id: record.id
        expect(response).to redirect_to(resources_path)
      end
    end
  end

  context "when a user is not signed-in" do
    RESTfuls::RESTFULS.each_value do |a|
      describe a[:description] do
        it "redirects to sign_in" do
          send(a[:action], a[:method], id: record.id)
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
