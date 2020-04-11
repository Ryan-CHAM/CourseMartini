class ApplicationController < ActionController::Base
    protect_from_forgery
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :first_time_visit?, unless: -> { cookies[:first_visit] }
    protected
    

  def first_time_visit?
     cookies[:first_visit] = 1
     redirect_to '/welcome'
  end

    def configure_permitted_parameters
      	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

end
