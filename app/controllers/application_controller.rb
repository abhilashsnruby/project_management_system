class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :get_user_details
  alias_method :devise_current_user, :current_user


  def get_user_details
    if params[:user].present?
      current_user ||=  User.find_by_email(params[:user][:email]).present?
      user_signed_in = current_user
    elsif params[:controller] == 'projects'
      current_user ||= User.last.present?
      user_signed_in = current_user
    end
  end

 def after_sign_out_path_for(resource_or_scope)
   if resource_or_scope == :user
     new_user_session_path
   elsif resource_or_scope == :admin
     new_admin_session_path
   else
     root_path
   end
 end

 def current_user
   if params[:user_id].blank?
      devise_current_user
   else
     User.find(params[:user_id])
   end
 end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_id, :user_name, :email, :password, :password_confirmation])
  end
end