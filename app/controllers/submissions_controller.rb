class SubmissionsController < ApplicationController
  before_action :require_student, only: [:create]
  before_action :require_mentor, only: [:edit, :update]
  before_action :set_course, only: [:new, :create]
  before_action :set_submission, only: %i[show edit update destroy]
 
  # GET /submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new
    @enrollments = @course.enrollments
    @lessons = @course.lessons
  end

  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      @enrollments = @course.enrollments
      @lessons = @course.lessons
      render :new
    end
  end

  # GET /submissions/1/edit
  def edit
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
  end

  def set_submission 
    @submission = Submission.find(params[:id])
  end 
  
  private
    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :mentor_id, :review_result, :reviewed_at, :url)
    end
end
