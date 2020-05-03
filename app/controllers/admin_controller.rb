=begin
ADMIN CONTROLLER – Controls the flow of data/ request in admin related views
PROGRAMMER: Hsieh Tzuchun
PURPOSE: Allow access of pages to the database
=end
class AdminController < ApplicationController
    # Determine if the user is admin or not before entering any admin pages
    before_action :is_admin?

    # GET /admin/index
    def index
    end

    # GET /admin/user_table
    def user_table
        @users = User.all
    end
    # If current user is not Admin, redirect to root
    def is_admin?
        redirect_to root_path unless current_user&.admin? 
      end
end
