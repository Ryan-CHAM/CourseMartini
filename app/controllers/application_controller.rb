class ApplicationController < ActionController::Base
    protect_from_forgery
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    
    def first_time_visiting?
      if cookies[:first_time].nil?
        cookies[:first_time] = true
        true
      else
        false
      end
    end

    def configure_permitted_parameters
      	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
