class ApplicationController < ActionController::Base
    before_action :set_proposal
    protect_from_forgery
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :first_time_visit?, unless: -> { cookies[:first_visit] }
    protected
    
    add_flash_types :warning
    
  def first_time_visit?
      unless user_signed_in? && !cookies[:first_visit]
        cookies[:first_visit] = 1
        redirect_to '/welcome'
      end
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def set_proposal
      @proposal_number = Proposal.all.size
      @proposal_exist = Proposal.first
  end

end
