class UsersController < ApplicationController
  before_action :create_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!




  # GET /users or /users.json
  def index
    @users = User.all
  end

  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy

    @courses = Course.where(instructor_name: @user.name )

    @courses.each do |course|
      course.destroy
    end

    @courses = Course.all

    @courses.each do |course|
      @enrollments = course.enrollments.where(student_id: @user.user_id)
      @enrollments.each do |enrollment|
        enrollment.destroy
      end
    end

    @user.destroy
    redirect_to root_path
    # respond_to do |format|
    #   format.html { redirect_to root_path, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user


    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :role, :email, :user_id, :date_of_birth, :phone_number, :department, :major)
  end

  def create_admin
    if User.all.where(role: "admin").length < 1
      @user = User.new(:role => "admin",
                       :name => "admin",
                       :user_id => "123",
                       :date_of_birth => "2020-03-04",
                       :email => "a@a.com",
                       :password => "123456",
                       :password_confirmation => "123456",
                       :phone_number => "1111111111")
      @user.save
    end
  end

end
