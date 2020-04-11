class CommentsController < ApplicationController
	before_action :check_sign_in



	def index
		@comments = Comment.all
	end

	def new
		
		@comment = Comment.new


		#still need user and course controller
	end

	def create
		@user=current_user
		@course=Course.first
		@comment = Comment.new(comment_params)
		@comment.update(user:@user,course:@course)
		@comment.courseid = @course.name
		@comment.username = @user.name
		#valid score
		#score will change to option bottum
		#username and course id will be unchangable after finishing course and user part
		if @comment.score>5 || @comment.score<0
			flash[:notice] = "invalid score"
			render :new

		elsif @comment.save	#success
			redirect_to comments_path, notice: "make new comment"#finally redirect to course page
		else				#fail
			render :new
		end
	end

	
	def update
		@user=current_user
		@course=Course.first
		@comment = Comment.new(comment_params)
		@comment.update(user:@user,course:@course)
		@comment.courseid = @course.name
		@comment.username = @user.name
		#valid score
		#score will change to option bottum
		#username and course id will be unchangable after finishing course and user part
		if @comment.score>5 || @comment.score<0
			flash[:notice] = "invalid score"
			render :new

		elsif @comment.save	#success
			redirect_to comments_path, notice: "make new comment"#finally redirect to course page
		else				#fail
			render :new
		end
	end

	def destroy
	    @comment = Comment.find_by(id: params[:id])
	    @comment.destroy if @comment
	    redirect_to comments_path, notice: "post delete!"
  	end


	private
	def comment_params
		params.require(:comment).permit( :gpa, :score,:workload_score, :teachingQuality_score, :difficulty_score, :usefulness_score, :posts)
	end

	def check_sign_in
		unless user_signed_in?
			flash[:notice] = "please sign in"
			redirect_to root_path
		end
	end

end
