class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized


  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:role, :name, :user_id, :date_of_birth, :phone_number, :department, :major, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:role,:name,  :user_id, :date_of_birth, :phone_number, :department, :major,:email, :password, :current_password)}
  end
  private

  def not_authorized
    flash[:alert] = "You don't have permission for that"
    redirect_back fallback_location: root_path
  end
end
