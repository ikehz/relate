require 'spec_helper'

describe HomeController do
  describe "GET #index" do
    # no resource to assign

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
end
