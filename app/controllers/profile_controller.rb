class ProfileController < ApplicationController

    def index 
        unless @user = User.find(params[:id])
            redirect_to root_path 
        end
        @count = Comment.where(:username => @user.name).count
        @last = Comment.where(:username => @user.name).last
    end

    def setting
        redirect_to root_path unless current_user
        @user = current_user
    end


end
