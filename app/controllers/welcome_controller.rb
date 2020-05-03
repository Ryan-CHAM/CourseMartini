=begin
PROFILE CONTROLLER – Controls the flow of data/ requests in profile views
PROGRAMMER: Hsieh, Tzuchun
PURPOSE: Cancel the render of layout on this page
=end
class WelcomeController < ApplicationController
  # GET /welcome
  # Disable the layout with navbar on this page
  def index
    render :layout => false
  end
end
