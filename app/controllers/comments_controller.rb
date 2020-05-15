=begin
COMMENT CONTROLLER – control the flow of data/ request in comment related views
PROGRAMMER: LI Jingchen
PURPOSE: Allow users to make comment on specific course | Allow admin to access all comments and delete comments
=end


class CommentsController < ApplicationController
	before_action :check_sign_in			#all option should after user sign in
	def index
		# this is the list of all comments which can only be seen by admin
		redirect_to root_path unless current_user&.admin? 	# check if the user is admin
		if params[:format]==nil			#check whether admin wants to see all comments or comments of a specific course
			@comments = Comment.all 	# all comments
		else
			@id=params[:format]
			@comments=Comment.where(course_id: @id)			#comments of one course, course id is get from params[:format]
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

		@user=current_user     		#@user is the user that is login now
		@id = params[:course_id] 	 #@id is equal to course_id 
		@course = Course.find_by(id: @id)
		@comment = Comment.new(comment_params)
		if Comment.where(user_id: @user.id, course_id: @id).exists?
			redirect_to @course, warning: "You cannot comment a course twice"
			return
		end
		@comment.update(user:@user, course:@course)
		@comment.courseid = @course.code

		@comment.username = @user.name
		# all scores get from slider in new_comment_path, the slider is in range 0..10 step=1, 
		# score should be in range 0..5
		# therefore each variable related to score divided by 2
		@comment.score=@comment.score/2
		@comment.workload_score=@comment.workload_score/2
		@comment.teachingQuality_score=@comment.teachingQuality_score/2
		@comment.difficulty_score=@comment.difficulty_score/2
		@comment.usefulness_score=@comment.usefulness_score/2

		if @comment.save	#success 
			@course.overall = (@course.overall*@course.n_comments+@comment.score)/(@course.n_comments+1)					# upadte course overall score
			@course.workload = (@course.workload*@course.n_comments+@comment.workload_score)/(@course.n_comments+1)			# upadte course workload score
			@course.quality = (@course.quality*@course.n_comments+@comment.teachingQuality_score)/(@course.n_comments+1)	# upadte course teaching quality score	
			@course.difficulty = (@course.difficulty*@course.n_comments+@comment.difficulty_score)/(@course.n_comments+1)	# upadte course difficulty score
			@course.usefulness = (@course.usefulness*@course.n_comments+@comment.usefulness_score)/(@course.n_comments+1)	# upadte course usefulness score
			@course.gpa = (@course.gpa*@course.n_comments+@comment.gpa)/(@course.n_comments+1)								# update course gpa
			@course.n_comments = @course.n_comments+1												# course's comments +1
			@course.save																			# save changes on course
			redirect_to @course, notice: "made new comment"		#finally redirect to course page
		else				#fail
			render :new 		# this will keep user's option, they don't need to rewrite
		end

	end

	# when comment.save fail, after render new, the submit button will be upadte, the method is same as create, usually comment.save will not fail
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
			redirect_to @course, notice: "updated comment"#finally redirect to course page

		else				#fail
			render :new
		end
	end


	# delete comment
	def destroy
	    @comment = Comment.find_by(id: params[:id])
	   	@course = Course.find_by(id: @comment.course_id)


	   	if @course.n_comments==1		# if the comment to be delete is the last one in its course
	   		# change all variable related to both course and comment to 0 manually, because if use "(avg*num_of_comment-this_var)/(num_of_comment-1)" will cause number/0 which will be a bug
	   		@course.overall = 0			
	   		@course.workload = 0	
	   		@course.quality = 0
			@course.difficulty = 0
			@course.usefulness = 0
			@course.gpa = 0
		else		
			#use "(avg*num_of_comment-this_var)/(num_of_comment-1)" to update those variable
		   	@course.overall = (@course.overall*@course.n_comments-@comment.score)/(@course.n_comments-1)
			@course.workload = (@course.workload*@course.n_comments-@comment.workload_score)/(@course.n_comments-1)
			@course.quality = (@course.quality*@course.n_comments-@comment.teachingQuality_score)/(@course.n_comments-1)
			@course.difficulty = (@course.difficulty*@course.n_comments-@comment.difficulty_score)/(@course.n_comments-1)
			@course.usefulness = (@course.usefulness*@course.n_comments-@comment.usefulness_score)/(@course.n_comments-1)
			@course.gpa = (@course.gpa*@course.n_comments-@comment.gpa)/(@course.n_comments-1)   	
	   	end
		@course.n_comments = @course.n_comments-1 	# update comments number in this course

	   	@course.save								# save the update on this course
	    @comment.destroy if @comment 				# make sure the comment is delete
	    redirect_to comments_path(@course), notice: "post delete!"
  	end


	private
	def comment_params

		params.require(:comment).permit( :gpa, :score,:workload_score, :teachingQuality_score, :difficulty_score, :usefulness_score, :posts)	# give permission to use params from formal page

	end

	
	# method on check if user is sign in
	def check_sign_in
		unless user_signed_in?
			flash[:warning] = "please sign in"
			redirect_to "/users/sign_in"
		end
	end

end
