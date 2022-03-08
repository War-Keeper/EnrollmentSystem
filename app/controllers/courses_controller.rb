class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /courses or /courses.json
  def index
    # @courses = Course.all

    if current_user.role == "instructor"
      @courses = Course.where(instructor_name: current_user.name )
    elsif  current_user.role == "student"
      @courses = Course.all
    else
      @courses = Course.all
    end
  end

  def show
  end

  # GET /courses/new
  def new
    @course = Course.new

    if current_user.role == "instructor"
      @course.instructor_name = current_user.name
    end

  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.status = "OPEN"
    if current_user.role == "instructor"
      @course.instructor_name = current_user.name
    end


      respond_to do |format|
        @users = User.where(name: @course.instructor_name)
        if @users.length < 1
          format.html { redirect_to [@course], notice: "Instructor Name is not Valid or Cannot be Found" }
          format.json { head :no_content }
        else


        if @course.save
          format.html { redirect_to @course, notice: "Course was successfully created." }
          format.json { render :show, status: :created, location: @course }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end



  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)

        if current_user.role == "instructor"
          @course.instructor_name = current_user.name
        end

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
    @enrollment = @course.enrollments.destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :description, :instructor_name, :weekday_one, :weekday_two, :start_time, :end_time, :course_code, :capacity, :waitlist_capacity, :status, :room)
    end
end
