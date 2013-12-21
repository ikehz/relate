class ParticipantsController < ApplicationController
  # only allow access to this controller if a user is signed in
  #
  # this should come before other callbacks so as to avoid errors popping up
  before_action :authenticate_user!
  before_action :set_participant, only: [:destroy]
  before_action :set_conversation, only: [:new, :create]
  before_action :set_contacts, only: [:new]

  # GET conversation/1/participants/new
  def new
    @participant = current_user.participants.new(conversation: @conversation)
  end

  # POST conversation/1/participants
  # POST conversation/1/participants.json
  def create
    @participant = current_user.participants.new(participant_params.merge conversation: @conversation)
    respond_to do |format|
      if @participant.save
        flash[:success] = 'Participant was successfully created.'
        format.html { redirect_to @conversation }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @conversation = @participant.conversation
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to @conversation }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = current_user.participants.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = current_user.conversations.find(params[:conversation_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contacts
      @contacts = current_user.contacts
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:contact_id)
    end
end
