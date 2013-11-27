# requires:
#   let (:nest_resource_name)
#   let (:nest_resource)
#   let (:resource_name)
#   let (:resources)
shared_examples "nested GET #index" do
  it "assigns the correct resource" do
    get :index, (nest_resource_name.to_s + '_id').to_sym => nest_resource
    expect(assigns(resource_name.to_s.pluralize.to_sym)).to eq(resources)
  end

  it "responds successfully with 200" do
    get :index, (nest_resource_name.to_s + '_id').to_sym => nest_resource
    expect(response).to be_success
    expect(response.status).to eq(200)
  end

  it "renders the correct template" do
    get :index, (nest_resource_name.to_s + '_id').to_sym => nest_resource
    expect(response).to render_template :index
  end
end

# requires:
#   let (:nest_resource_name)
#   let (:nest_resource)
#   let (:resource_name)
shared_examples "nested GET #new" do
  it "assigns a new resource with the correct nest resource" do
    get :new, (nest_resource_name.to_s + '_id').to_sym => nest_resource
    expect(assigns(resource_name)).to be_new_record
    expect(assigns(resource_name).send(nest_resource_name)).to eq(nest_resource)
  end

  it "responds successfully with 200" do
    get :new, (nest_resource_name.to_s + '_id').to_sym => nest_resource
    expect(response).to be_success
    expect(response.status).to eq(200)
  end

  it "renders the correct template" do
    get :new, (nest_resource_name.to_s + '_id').to_sym => nest_resource
    expect(response).to render_template :new
  end
end

# requires:
#   let (:nest_resource_name)
#   let (:nest_resource)
#   let (:resource_name)
#   let (:update_resource)
#   let (:invalid_resource)
shared_examples "nested POST #create" do
  context "with valid attributes" do
    it "saves the new resource with correct nest resource" do
      post :create, (nest_resource_name.to_s + '_id').to_sym => nest_resource, resource_name => update_resource.attributes
      expect(assigns(resource_name)).not_to be_new_record
      expect(assigns(resource_name).send(nest_resource_name)).to eq(nest_resource)
    end

    it "redirects to resource with flash message" do
      post :create, (nest_resource_name.to_s + '_id').to_sym => nest_resource, resource_name => update_resource.attributes
      expect(response).to redirect_to(assigns(resource_name))
      expect(flash[:success]).not_to be_nil
    end
  end

  context "with invalid attributes" do
    it "does not save the new resource" do
      post :create, (nest_resource_name.to_s + '_id').to_sym => nest_resource, resource_name => invalid_resource.attributes
      expect(assigns(resource_name)).to be_new_record
    end

    it "responds successfully with 200" do
      post :create, (nest_resource_name.to_s + '_id').to_sym => nest_resource, resource_name => invalid_resource.attributes
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the :new template" do
      post :create, (nest_resource_name.to_s + '_id').to_sym => nest_resource, resource_name => invalid_resource.attributes
      expect(response).to render_template :new
    end
  end
end

# requires:
#   let (:nest_resource_name)
#   let (:nest_resource)
#   let (:resource_name)
#   let (:resource)
shared_examples "nested DELETE #destroy" do
  it "destroys the Resource" do
    delete :destroy, id: resource
    expect(assigns(resource_name)).to be_destroyed
  end

  it "redirects to index" do
    delete :destroy, id: resource
    expect(response).to redirect_to(send(nest_resource_name.to_s + '_' + resource_name.to_s.pluralize + '_path', nest_resource))
  end
end

# requires:
#   let (:nest_resource_name)
#   let (:nest_resource)
#   let (:resource_name)
#   let (:resource)
#   let (:invalid_resource)
#   let (:update_resource)
#   let (:update_attribute)
shared_examples "a nested RESTful resource" do
  describe "GET #index" do
    it_behaves_like "nested GET #index" do
      let (:resources) { [resource] }
    end
  end

  describe "GET #new" do
    it_behaves_like "nested GET #new"
  end

  describe "POST #create" do
    it_behaves_like "nested POST #create"
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
    it_behaves_like "nested DELETE #destroy"
  end
end
