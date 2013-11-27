shared_examples "GET #index" do
  it "assigns the correct resource" do
    get :index
    expect(assigns(resource_name.to_s.pluralize.to_sym)).to eq(resources)
  end

  it "responds successfully with 200" do
    get :index
    expect(response).to be_success
    expect(response.status).to eq(200)
  end

  it "renders the correct template" do
    get :index
    expect(response).to render_template :index
  end
end

shared_examples "GET #new" do
  it "assigns a new resource" do
    get :new
    expect(assigns(resource_name)).to be_new_record
  end

  it "responds successfully with 200" do
    get :new
    expect(response).to be_success
    expect(response.status).to eq(200)
  end

  it "renders the correct template" do
    get :new
    expect(response).to render_template :new
  end
end

shared_examples "POST #create" do
  context "with valid attributes" do
    it "saves the new resource" do
      post :create, resource_name => resource.attributes
      expect(assigns(resource_name)).not_to be_new_record
    end

    it "redirects to resource with flash message" do
      post :create, resource_name => resource.attributes
      expect(response).to redirect_to(assigns(resource_name))
      expect(flash[:success]).not_to be_nil
    end
  end

  context "with invalid attributes" do
    it "does not save the new resource" do
      post :create, resource_name => invalid_resource.attributes
      expect(assigns(resource_name)).to be_new_record
    end

    it "responds successfully with 200" do
      post :create, resource_name => invalid_resource.attributes
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the :new template" do
      post :create, resource_name => invalid_resource.attributes
      expect(response).to render_template :new
    end
  end
end

shared_examples "GET #show" do
  it "assigns the correct resource" do
    get :show, id: resource
    expect(assigns(resource_name)).to eq(resource)
  end

  it "responds successfully with 200" do
    get :show, id: resource
    expect(response).to be_success
    expect(response.status).to eq(200)
  end

  it "renders the correct template" do
    get :show, id: resource
    expect(response).to render_template :show
  end
end

shared_examples "GET #edit" do
  it "assigns the correct resource" do
    get :edit, id: resource
    expect(assigns(resource_name)).to eq(resource)
  end

  it "responds successfully with 200" do
    get :edit, id: resource
    expect(response).to be_success
    expect(response.status).to eq(200)
  end

  it "renders the correct template" do
    get :edit, id: resource
    expect(response).to render_template :edit
  end
end

shared_examples "PATCH #update" do
  context "with valid attributes" do
    it "updates the resource" do
      patch :update, id: resource, resource_name => update_resource.attributes
      expect(resource.reload.send(update_attribute)).to eq(update_resource.send(update_attribute))
    end

    it "redirects to resource with flash message" do
      patch :update, id: resource, resource_name => update_resource.attributes
      expect(response).to redirect_to(assigns(resource_name))
      expect(flash[:success]).not_to be_nil
    end
  end

  context "with invalid attributes" do
    it "does not update the resource" do
      patch :update, id: resource, resource_name => invalid_resource.attributes
      expect(resource.reload.send(update_attribute)).to eq(resource.send(update_attribute))
    end

    it "responds successfully with 200" do
      patch :update, id: resource, resource_name => invalid_resource.attributes
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the :edit template" do
      patch :update, id: resource, resource_name => invalid_resource.attributes
      expect(response).to render_template :edit
    end
  end
end

shared_examples "DELETE #destroy" do
  it "destroys the Resource" do
    delete :destroy, id: resource
    expect(assigns(resource_name)).to be_destroyed
  end

  it "redirects to index" do
    delete :destroy, id: resource
    expect(response).to redirect_to(eval(resource_name.to_s.pluralize + '_path'))
  end
end

shared_examples "a RESTful resource" do
  describe "GET #index" do
    it_behaves_like "GET #index" do
      let (:resources) { [resource] }
    end
  end

  describe "GET #new" do
    it_behaves_like "GET #new"
  end

  describe "POST #create" do
    it_behaves_like "POST #create"
  end

  describe "GET #show" do
    it_behaves_like "GET #show"
  end

  describe "GET #edit" do
    it_behaves_like "GET #edit"
  end

  describe "PATCH #update" do
    it_behaves_like "PATCH #update"
  end

  describe "DELETE #destroy" do
    it_behaves_like "DELETE #destroy"
  end
end
