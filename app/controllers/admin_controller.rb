class AdminController < ApplicationController
    def user_table
        @users = User.all
    end
end
