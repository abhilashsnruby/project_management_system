class SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  prepend_before_action :verify_signed_out_user, only: :destroy
  prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }
  prepend_before_action :require_no_authentication, only: [:cancel ]
  respond_to :html, :json, :js

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = User.find_by_user_name(sign_in_params['user_name'])
    set_flash_message!(:notice, :signed_in) if resource.roles.present?
    sign_in(resource_name, resource)
    yield resource if block_given?

    if resource.roles.present?
      if params['role_name'].present?
        role_name = eval(params['role_name'][0])
        user_role_name = role_name.values[0]
        user_sign_in_path = check_user_condition_for_login_path(user_role_name)
        respond_with resource, location: user_sign_in_path
      else
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    else
      flash[:alert] = alert_role_not_assigned_message
      redirect_to user_session_path
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  private

  def auth_resource_option
    warden.authenticate!(auth_options)
  end

  def alert_role_not_assigned_message
    "There is no role being assigned to #{resource.user_name} - assign role by logging in as admin"
  end

  def user_session_path
    new_user_session_path
  end

  def check_user_condition_for_login_path(user_role_name)
    (user_role_name == 'moderator') ? "/dashboard/index" : "/admin"
  end

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def verify_signed_out_user
    if all_signed_out?
      set_flash_message! :notice, :already_signed_out

      respond_to_on_destroy
    end
  end

  def all_signed_out?
    users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

    users.all?(&:blank?)
  end

end