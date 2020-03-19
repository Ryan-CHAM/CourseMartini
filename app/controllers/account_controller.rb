class AccountController < ApplicationController
    protect_from_forgery
    def signup
        @user = User.new
    end
    
    def signin
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
          redirect_to "/admin/user_table"
        else
          render :signup
        end
    end
    

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
