class ProfileController < ApplicationController
    
    def index 
        unless @user = User.find(params[:id])
            redirect_to root_path 
        end
        @count = Comment.where(:username => @user.name).count
        @comment = Comment.where(:username => @user.name).last

    end

    def setting  
        redirect_to root_path unless current_user
        @user = current_user
    end

    def update
        @user = current_user
        @name = @user.name
        @intro = @user.intro
        unless params[:name] == "" 
            @user.name = params[:name] 
        end
        unless params[:intro] == ""
            @user.intro = params[:intro] 
        end
        if @user.save
            redirect_to "/profile/#{@user.id}",
            :notice => "Update successful!"
        else
            @user.name = @name
            @user.intro = @intro
            render :setting
        end
    end

    def comments
        @user = User.find(params[:id])
        @comments = Comment.where(:user_id => @user.id)
    end   
    

end
