class EnrollmentsController < ApplicationController
  before_action :set_course
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /enrollments or /enrollments.json
  def index
    @enrollments = @course.enrollments
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = @course.enrollments.build
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments or /enrollments.json
  def create

    @enrollment = @course.enrollments.build(enrollment_params)

    @users = nil

    if current_user.role == "student"
      @users = User.where(user_id: current_user.user_id)
      @enrollment.student_id = current_user.user_id
    else
      @users = User.where(user_id: @enrollment.student_id, role: "student")
    end


    respond_to do |format|

      if @users.length < 1
        format.html { redirect_to [@course], notice: "Invalid Student ID, please enter a valid student ID" }
        format.json { head :no_content }

      elsif @course.capacity <= @course.enrollments.length
        format.html { redirect_to [@course], notice: "Course Capacity has been reached" }
        format.json { head :no_content }

      else

        if @course.enrollments.where(student_id: @enrollment.student_id).length > 0
          format.html { redirect_to [@course], notice: "Student is already enrolled" }
          format.json { head :no_content }

        else
          if @enrollment.save
            format.html { redirect_to [@course], notice: "Enrollment was successfully updated." }
            format.json { render :show, status: :ok, location: @enrollment }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @enrollment.errors, status: :unprocessable_entity }
          end
        end

        if @course.capacity == @course.enrollments.length
          @course.status = "CLOSED"
        else
          @course.status = "OPEN"
        end

      end


    end


  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to [@course, @enrollment], notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy
    redirect_to course_path(@course)
    # respond_to do |format|
    #   format.html { redirect_to [@course], notice: "Enrollment was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = @course.enrollments.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:student_id)
    end
end
