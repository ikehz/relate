class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  # XXX should this be private or protected?
  protected
    # Never trust parameters from the scary internet, only allow the white list through.
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).concat([:username,:name])
      devise_parameter_sanitizer.for(:sign_in).concat([:username])
      devise_parameter_sanitizer.for(:account_update).concat([:username,:name])
    end
end
