=begin
Profile Controller – Controls the flow of data/ requests in profile views
PROGRAMMER: Hsieh, Tzuchun
PURPOSE: Allow access of pages to the database/ organsize gathered data in required formats
=end
class ProfileController < ApplicationController
    # GET /profile/{id}
    # Index is the page showing personal profiles of any user
    # The "params" are passed by address. e.g. "localhost:3000/profile/1"
    def index 
        unless @user = User.find(params[:id])
            redirect_to root_path 
        end
        # Number of comments the user has
        @count = Comment.where(:username => @user.name).count
        # The last comment of the user
        @comment = Comment.where(:username => @user.name).last

    end

    # GET /profile/setting
    # Page allowing user to change username / self introduction
    def setting  
        redirect_to root_path unless current_user
        @user = current_user
    end

    # POST /profile/update
    # updates personal information: username /introduction
    def update
        @user = current_user
        @name = @user.name
        @intro = @user.intro
        # If inputs are blank, change nothing
        unless params[:name] == "" 
            @user.name = params[:name] 
        end
        unless params[:intro] == ""
            @user.intro = params[:intro] 
        end
        # If username/intro are valid, redirect to profile page and notice a "success"
        if @user.save
            redirect_to "/profile/#{@user.id}",
            :notice => "Update successful!"
        # If invalid, render the setting page again
        else
            @user.name = @name
            @user.intro = @intro
            render :setting
        end
    end

    # GET /profile/comments
    # Displaying all comments by a certain user
    def comments
        @user = User.find(params[:id])
        @comments = Comment.where(:user_id => @user.id)
    end   
    

end
