class CommentsController < ApplicationController
	
	def index
		@comments = Comment.all
	end

	def new
		
		@comment = Comment.new
		#@comment.user_id = User.id
		#still need user and course controller
	end

	def create
		@comment = Comment.new(comment_params)
		#valid score
		#score will change to option bottum
		#username and course id will be unchangable after finishing course and user part
		if @comment.score>5 || @comment.score<0
			flash[:notice] = "invalid score"
			render :new

		else if @comment.save	#success
			redirect_to comments_path, notice: "make new comment"#finally redirect to course page
		else				#fail
			puts(@comment.errors)
			render :new
		end
		
		end
	end

	def destroy
	    @comment = Comment.find_by(id: params[:id])
	    @comment.destroy if @comment
	    redirect_to comments_path, notice: "post delete!"
  	end


	private
	def comment_params
		params.require(:comment).permit(:username, :courseid, :score,:workload_score, :teachingQuality_score, :difficulty_score, :usefulness_score, :posts)
	end


end
