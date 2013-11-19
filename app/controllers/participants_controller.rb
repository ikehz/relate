class ParticipantsController < ApplicationController
  # only allow access to this controller if a user is signed in
  #
  # this should come before other callbacks so as to avoid errors popping up
  before_action :authenticate_user!
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :set_conversation, only: [:index, :new, :create]

  # GET conversation/1/participants
  # GET conversation/1/participants.json
  def index
    @participants = Participant.where(conversation: @conversation)
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET conversation/1/participants/new
  def new
    @participant = Participant.new(conversation: @conversation)
  end

  # GET /participants/1/edit
  def edit
  end

  # POST conversation/1/participants
  # POST conversation/1/participants.json
  def create
    @participant = Participant.new(participant_params)
    @participant.conversation = @conversation
    @participant.owner = current_user

    respond_to do |format|
      if @participant.save
        flash[:success] = 'Participant was successfully created.'
        format.html { redirect_to @participant }
        format.json { render action: 'show', status: :created, location: @participant }
      else
        format.html { render action: 'new' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        flash[:success] = 'Participant was successfully updated.'
        format.html { redirect_to @participant }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
      format.html { redirect_to conversation_participants_url(@conversation) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:date, :notes)
    end
end
