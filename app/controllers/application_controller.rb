class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?
  def after_sign_in_path_for(_resource)
    users_path
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :name, :photo, :bio, :password, :password_confirmation, :role)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :name, :photo, :bio, :password, :current_password, :password_confirmation, :role)
    end
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_session_path(resource_name) if is_navigational_format?
  end
end
