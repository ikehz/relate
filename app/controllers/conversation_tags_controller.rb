class ConversationTagsController < ApplicationController
  # only allow access to this controller if a user is signed in
  #
  # this should come before other callbacks so as to avoid errors popping up
  before_action :authenticate_user!
  before_action :set_conversation_tag, only: [:destroy]
  before_action :set_conversation, only: [:new, :create]
  before_action :set_tags, only: [:new]

  # GET conversation/1/conversation_tags/new
  def new
    @conversation_tag = current_user.conversation_tags.new(conversation: @conversation)
  end

  # POST conversation/1/conversation_tags
  def create
    @conversation_tag = current_user.conversation_tags.new(conversation_tag_params.merge conversation: @conversation)
    respond_to do |format|
      if @conversation_tag.save
        flash[:success] = 'Tag was successfully added.'
        format.html { redirect_to @conversation }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # DELETE /conversation_tags/1
  def destroy
    @conversation = @conversation_tag.conversation
    @conversation_tag.destroy
    respond_to do |format|
      format.html { redirect_to @conversation }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation_tag
      @conversation_tag = current_user.conversation_tags.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = current_user.conversations.find(params[:conversation_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_tags
      @tags = current_user.tags
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_tag_params
      params.require(:conversation_tag).permit(:tag_id)
    end
end
