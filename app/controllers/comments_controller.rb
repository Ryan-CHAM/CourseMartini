class CommentsController < ApplicationController
	before_action :check_sign_in
	def index
		redirect_to root_path unless current_user&.admin? 
		if params[:format]==nil
			@comments = Comment.all
		else
			@id=params[:format]
			@comments=Comment.where(course_id: @id)	
		end		
	end

	def new
		#render json: params
		$courseidforcomment = params[:format]
		@id = $courseidforcomment
		@course = Course.find_by(id: @id)
		if @course==nil
			redirect_to root_path
		end
		@comment = Comment.new
		
		

		#still need user and course controller
	end

	def create

		#render json: params

		@user=current_user

		
		@id = params[:course_id]
		@course = Course.find_by(id: @id)

		@comment = Comment.new(comment_params)
		@comment.update(user:@user, course:@course)
		@comment.courseid = @course.code

		@comment.username = @user.name
		#valid score
		#score will change to option bottum
		#username and course id will be unchangable after finishing course and user part
		@comment.score=@comment.score/2
		@comment.workload_score=@comment.workload_score/2
		@comment.teachingQuality_score=@comment.teachingQuality_score/2
		@comment.difficulty_score=@comment.difficulty_score/2
		@comment.usefulness_score=@comment.usefulness_score/2

		if @comment.save	#success
			
			@course.overall = (@course.overall*@course.n_comments+@comment.score)/(@course.n_comments+1)
			@course.workload = (@course.workload*@course.n_comments+@comment.workload_score)/(@course.n_comments+1)
			@course.quality = (@course.quality*@course.n_comments+@comment.teachingQuality_score)/(@course.n_comments+1)
			@course.difficulty = (@course.difficulty*@course.n_comments+@comment.difficulty_score)/(@course.n_comments+1)
			@course.usefulness = (@course.usefulness*@course.n_comments+@comment.usefulness_score)/(@course.n_comments+1)
			@course.gpa = (@course.gpa*@course.n_comments+@comment.gpa)/(@course.n_comments+1)
			@course.n_comments = @course.n_comments+1
			@course.save
			redirect_to @course, notice: "make new comment"#finally redirect to course page

		else				#fail
			render :new
		end

	end

	
	def update
		@user=current_user
		@id=$courseidforcomment
		@course=Course.find_by(id: @id)
		@comment = Comment.new(comment_params)
		@comment.update(user:@user,course:@course)
		@comment.courseid = @course.name
		@comment.username = @user.name
		#valid score
		#score will change to option bottum
		#username and course id will be unchangable after finishing course and user part
		@comment.score=@comment.score/2
		@comment.workload_score=@comment.workload_score/2
		@comment.teachingQuality_score=@comment.teachingQuality_score/2
		@comment.difficulty_score=@comment.difficulty_score/2
		@comment.usefulness_score=@comment.usefulness_score/2



		if @comment.save	#success
			@course.overall = (@course.overall*@course.n_comments+@comment.score)/(@course.n_comments+1)
			@course.workload = (@course.workload*@course.n_comments+@comment.workload_score)/(@course.n_comments+1)
			@course.quality = (@course.quality*@course.n_comments+@comment.teachingQuality_score)/(@course.n_comments+1)
			@course.difficulty = (@course.difficulty*@course.n_comments+@comment.difficulty_score)/(@course.n_comments+1)
			@course.usefulness = (@course.usefulness*@course.n_comments+@comment.usefulness_score)/(@course.n_comments+1)
			@course.gpa = (@course.gpa*@course.n_comments+@comment.gpa)/(@course.n_comments+1)
			@course.n_comments = @course.n_comments+1
			@course.save
			redirect_to @course, notice: "make new comment"#finally redirect to course page

		else				#fail
			render :new
		end
	end

	def destroy

	    @comment = Comment.find_by(id: params[:id])
	   	@course = Course.find_by(id: @comment.course_id)
	   	@course.overall = (@course.overall*@course.n_comments-@comment.score)/(@course.n_comments-1)
		@course.workload = (@course.workload*@course.n_comments-@comment.workload_score)/(@course.n_comments-1)
		@course.quality = (@course.quality*@course.n_comments-@comment.teachingQuality_score)/(@course.n_comments-1)
		@course.difficulty = (@course.difficulty*@course.n_comments-@comment.difficulty_score)/(@course.n_comments-1)
		@course.usefulness = (@course.usefulness*@course.n_comments-@comment.usefulness_score)/(@course.n_comments-1)
		@course.gpa = (@course.gpa*@course.n_comments-@comment.gpa)/(@course.n_comments-1)
	   	@course.n_comments = @course.n_comments-1
	   	@course.save
	    @comment.destroy if @comment
	    redirect_to comments_path(@course), notice: "post delete!"
  	end


	private
	def comment_params

		params.require(:comment).permit( :gpa, :score,:workload_score, :teachingQuality_score, :difficulty_score, :usefulness_score, :posts)

	end

	

	def check_sign_in
		unless user_signed_in?
			flash[:warning] = "please sign in"
			redirect_to "/users/sign_in"
		end
	end

end
