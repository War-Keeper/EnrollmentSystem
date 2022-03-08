class InstructorController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.where(instructor_name: current_user.name )
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
