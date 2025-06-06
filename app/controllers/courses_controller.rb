class CoursesController < ApplicationController
  before_action :require_admin, only: %i[ new create edit update destroy ]
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

    # GET /api/v1/courses
    def indexApi
      @courses = Course.all
      render json: {  courses: @courses }
    end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /api/v1/courses/1
  def showApi
    @course = Course.find(params.expect(:id))
    render json: {course: @course, students: @course.student_name_list}
  end

  # GET /courses/new
  def new
    @course = Course.new
    @coding_classes = CodingClass.all
    @trimesters = Trimester.all
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        # Redirect to the course page
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        # Re-render the new course form. The view already contains
        # logic to display the errors in @course.errors
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.expect(course: [ :coding_class_id, :trimester_id, :max_enrollment ])
    end
end
