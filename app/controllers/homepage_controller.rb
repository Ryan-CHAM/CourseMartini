class HomepageController < ApplicationController
  def home
    if first_time_visiting?
      redirect_to '/welcome'
    end 
  end
end