class ConversationsController < ApplicationController
  # only allow access to this controller if a user is signed in
  #
  # this should come before other callbacks so as to avoid errors popping up
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = current_user.conversations
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @participants = @conversation.participants
  end

  # GET /conversations/new
  def new
    @conversation = current_user.conversations.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = current_user.conversations.new(conversation_params)
    respond_to do |format|
      if @conversation.save
        flash[:success] = 'Conversation was successfully created.'
        format.html { redirect_to @conversation }
        format.json { render action: 'show', status: :created, location: @conversation }
      else
        format.html { render action: 'new' }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        flash[:success] = 'Conversation was successfully updated.'
        format.html { redirect_to @conversation }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = current_user.conversations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:description, :date, :notes)
    end
end
