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

    def update
        @user = current_user
        @name = @user.name
        @intro = @user.intro
        @user.name = params[:name]
        @user.intro = params[:intro]
        if @user.save
            redirect_to "/profile/#{@user.id}",
            :notice => "Update successful!"
        else
            @user.name = @name
            @user.intro = @intro
            render :setting
        end
    end


    
    

end