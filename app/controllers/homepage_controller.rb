class HomepageController < ApplicationController
  include Devise::Controllers::Helpers 
  @user = current_user
  def home
    if first_time_visiting?
      redirect_to '/welcome'
    end 
  end
end