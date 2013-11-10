class SignUpsController < ApplicationController
  before_action :set_sign_up, only: [:show, :edit, :update, :destroy]

  # GET /sign_ups
  # GET /sign_ups.json
  # def index
  #   @sign_ups = SignUp.all
  # end

  # GET /sign_ups/1
  # GET /sign_ups/1.json
  # def show
  # end

  # GET /sign_ups/new
  def new
    @sign_up = SignUp.new
  end

  # GET /sign_ups/1/edit
  # def edit
  # end

  # POST /sign_ups
  # TODO: POST /sign_ups.json
  def create
    @sign_up = SignUp.new(sign_up_params)

    respond_to do |format|
      if @sign_up.save
        flash[:success] = "Thanks!  We'll keep in touch."
        format.html { redirect_to root_path }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /sign_ups/1
  # PATCH/PUT /sign_ups/1.json
  # def update
  #   respond_to do |format|
  #     if @sign_up.update(sign_up_params)
  #       flash[:success] = 'Sign Up was successfully updated.'
  #       format.html { redirect_to @sign_up }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @sign_up.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /sign_ups/1
  # DELETE /sign_ups/1.json
  # def destroy
  #   @sign_up.destroy
  #   respond_to do |format|
  #     format.html { redirect_to sign_ups_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_sign_up
    #   @sign_up = SignUp.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sign_up_params
      params.require(:sign_up).permit(:email, :build, :mobilize, :share)
    end
end
