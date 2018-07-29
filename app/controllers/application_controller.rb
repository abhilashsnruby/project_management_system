class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_session_parameters, if: :devise_controller?
  after_action :get_user_details
  alias_method :devise_current_user, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
    ## this render call should be:
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

  def multi_authorize(actions, model, all: true)
    predicate = all ? :all? : :any?
    actions.send(predicate) do |action|
      begin
        authorize! action, model
      rescue CanCan::AccessDenied => e
        false
      end
    end
  end

  def check_for_moderate_users
    authorize! :read, @projects
  end

  def check_admin_authorization
    if validata_admin_users
      multi_authorize([:read, :create, :update], Project, all: '')
    end
  end

  def return_for_super_user?
    super_user = ["superuser", "super_user"]
    if (User.count > 0)
      super_user_exists = User.where(user_name: super_user).present? ? true : false
    end
    super_user_exists
  end

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

 def validata_admin_users
   current_user.has_role?('superuser') ||
   current_user.has_role?('super_user') ||
   current_user.has_role?('admin')
 end

 def current_user
   if params[:user_id].blank?
      devise_current_user
   else
     User.find(params[:user_id])
   end
 end

  protected

  def configure_session_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:user_id, :user_name, :email, :password, :remember_me)
    end
  end
end