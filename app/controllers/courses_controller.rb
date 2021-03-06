=begin
COURSE CONTROLLER – Controls the actions related to courses
PROGRAMMER:   Zhou Jinan
VERSION:      last update 2020-4-20
PURPOSE:      Setup the access of the course database; connect the course with comments and proposals. 
              Control the workflow of course creation, delete and edit. 
=end


class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    redirect_to root_path unless current_user&.admin? 
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @comments=Comment.where(course_id: params[:id]).reorder(id: :desc)
    array = Array.new
    array[0] = ['User', 'Overall', 'Teaching Quality','Workload','Usefulness','Difficulty']
    i = 1
    @comments.each do |comment|
        array[i] = [comment.username, comment.score, comment.teachingQuality_score, comment.workload_score, comment.usefulness_score,comment.difficulty_score]
        i = i + 1
        if i == 11
          break
        end
    end
    
    @trend = array.to_json.html_safe
  end

  # GET /courses/new
  def new
    redirect_to root_path unless current_user&.admin? 
    if params[:format]
      @proposal = Proposal.find(params[:format])
      @course = Course.new
      @course.code = @proposal.code
      @course.name = @proposal.name
      @course.subject = @proposal.subject
      @course.faculty = @proposal.faculty
      @course.instructor = @proposal.instructor
      @course.description = @proposal.description
      @course.book = @proposal.book
      @course.url = @proposal.url
      @flag = 1
    else
    @course = Course.new
    @flag = 0
    end
  end

  # GET /courses/1/edit
  def edit
    redirect_to root_path unless current_user&.admin? 
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.code = @course.code.upcase
    respond_to do |format|
      if @course.save
        @proposal = Proposal.where(:code => @course.code).last
        if @proposal != nil
          @proposal.destroy
        end
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
          format.html { redirect_to @course, notice: 'Course was successfully updated.' }
          format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    redirect_to root_path unless current_user&.admin?

    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  # GET /search
  def search
      if params[:search] == ""
        redirect_to "/random"
      end
      @courses = Course.where("courses.code LIKE ?", "%#{params[:search].upcase}%").page(params[:page]).per(5)
  end
  
  # GET /random
  def random
      @courses = Course.random
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:code, :name, :subject, :faculty, :description, :workload, :difficulty, :quality, :usefulness, :gpa, :overall, :n_comments, :book, :url, :instructor)
    end


end
