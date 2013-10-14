class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).concat([:username,:name])
    devise_parameter_sanitizer.for(:sign_in).concat([:username,:name])
    devise_parameter_sanitizer.for(:account_update).concat([:username,:name])
  end
end
