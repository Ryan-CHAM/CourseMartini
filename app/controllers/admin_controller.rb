class AdminController < ApplicationController
    before_action :is_admin?

    def index

    end

    def user_table
        @users = User.all
    end

    def is_admin?
        redirect_to root_path unless current_user&.admin? 
      end
end
