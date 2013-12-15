# requires:
#   let (:unowned_resource)
shared_examples "GET #show unowned" do
  it "does not find resource" do
    expect{get :show, id: unowned_resource}.to raise_error(ActiveRecord::RecordNotFound)
  end
end

# requires:
#   let (:unowned_resource)
shared_examples "GET #edit unowned" do
  it "does not find resource" do
    expect{get :edit, id: unowned_resource}.to raise_error(ActiveRecord::RecordNotFound)
  end
end

# requires:
#   let (:unowned_resource)
shared_examples "PATCH #update unowned" do
  it "does not find resource" do
    expect{patch :update, id: unowned_resource}.to raise_error(ActiveRecord::RecordNotFound)
  end
end

# requires:
#   let (:unowned_resource)
shared_examples "DELETE #destroy unowned" do
  it "does not find resource" do
    expect{delete :destroy, id: unowned_resource}.to raise_error(ActiveRecord::RecordNotFound)
  end
end

# requires:
#   let (:unowned_resource)
shared_examples "a RESTful unowned resource controller" do
  if described_class.method_defined?(:show)
    describe "GET #show" do
      it_behaves_like "GET #show unowned"
    end
  end

  if described_class.method_defined?(:edit)
    describe "GET #edit" do
      it_behaves_like "GET #edit unowned"
    end
  end

  if described_class.method_defined?(:update)
    describe "PATCH #update" do
      it_behaves_like "PATCH #update unowned"
    end
  end

  if described_class.method_defined?(:destroy)
    describe "DELETE #destroy" do
      it_behaves_like "DELETE #destroy unowned"
    end
  end
end
