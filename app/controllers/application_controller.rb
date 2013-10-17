class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # for Grant::User.current_user
  #
  # would have just created a current_user method, but
  # that seems to mess with Devise's user_signed_in? method
  #
  # See Grant's README.rdoc for more information
  before_filter :set_grant_user_current_user

  private

  # set Grant::User.current_user
  def set_grant_user_current_user
    Grant::User.current_user = @current_user
  end

  rescue_from Grant::Error do |error|
    head :forbidden
  end
end
