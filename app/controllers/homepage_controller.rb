class HomepageController < ApplicationController
  def home
    if @first_visit 
      redirect_to '/welcome'
    end 
  end
end