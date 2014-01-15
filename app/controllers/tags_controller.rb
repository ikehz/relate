class TagsController < ApplicationController
  # only allow access to this controller if a user is signed in
  #
  # this should come before other callbacks so as to avoid errors popping up
  before_action :authenticate_user!
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  def index
    @tags = current_user.tags
  end

  # GET /tags/1
  def show
    @conversations = @tag.conversations
  end

  # GET /tags/new
  def new
    @tag = current_user.tags.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = current_user.tags.new(tag_params)
    respond_to do |format|
      if @tag.save
        flash[:success] = 'Tag was successfully created.'
        format.html { redirect_to @tag }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /tags/1
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        flash[:success] = 'Tag was successfully updated.'
        format.html { redirect_to @tag }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = current_user.tags.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
