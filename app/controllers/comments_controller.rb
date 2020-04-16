class CommentsController < ApplicationController
	before_action :check_sign_in



	def index
			#render json: params
			@id = params[:format]
			if @id != nil
				@comments = Comment.where(course_id: params[:format])
			else
				@comments = Comment.all
			end
	end

	def new
		@id = params[:format]
		@course = Course.find_by(id: @id)
		@comment = Comment.new
		@comment.course_id = @id
		

		#still need user and course controller
	end

	def create
		render json: params
=begin
		@user=current_user
		
		@comment = Comment.new(comment_params)
		@id = @comment.course_id
		@course = Course.find_by(id: @id)
		@comment.update(user:@user, course:@course)
		#@comment.courseid = @course.name
		@comment.username = @user.name
		#valid score
		#score will change to option bottum
		#username and course id will be unchangable after finishing course and user part
		@comment.score=@comment.score/2
		@comment.workload_score=@comment.workload_score/2
		@comment.teachingQuality_score=@comment.teachingQuality_score/2
		@comment.difficulty_score=@comment.difficulty_score/2
		@comment.usefulness_score=@comment.usefulness_score/2
		if @comment.score>5 || @comment.score<0
			flash[:notice] = "invalid score"
			render :new

		elsif @comment.save	#success
			redirect_to comments_path(@id), notice: "make new comment"#finally redirect to course page
		else				#fail
			render :new
		end
=end
	end

	
	def update
		@user=current_user
		@course=Course.second
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
		params.require(:comment).permit( :gpa, :score,:workload_score, :teachingQuality_score, :difficulty_score, :usefulness_score, :posts, :course_id, :courseid)
	end

	

	def check_sign_in
		unless user_signed_in?
			flash[:notice] = "please sign in"
			redirect_to root_path
		end
	end

end
