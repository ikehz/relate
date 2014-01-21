class OrganizationsController < ApplicationController
  # only allow access to this controller if a user is signed in
  #
  # this should come before other callbacks so as to avoid errors popping up
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  def index
    @organizations = current_user.organizations
  end

  # GET /organizations/1
  def show
  end

  # GET /organizations/new
  def new
    @organization = current_user.organizations.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  def create
    @organization = current_user.organizations.new(organization_params)
    respond_to do |format|
      if @organization.save
        @organization.users << current_user
        flash[:success] = 'Organization was successfully created.'
        format.html { redirect_to @organization }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /organizations/1
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        flash[:success] = 'Organization was successfully updated.'
        format.html { redirect_to @organization }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /organizations/1
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = current_user.organizations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:title)
    end
end
