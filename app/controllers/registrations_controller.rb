class RegistrationsController < Devise::RegistrationsController
  
  def create
    # logger.info "Attempt to sign in by #{ params[:user][:email] }"
    
    @user = User.new(sign_up_params)
    user = @user
    users = User.all
    status = User.check_super_user_exists(users,user) if users.present?
    if status.to_s == "true"
      flash[:alert] = "#{ user.email } is super user, create another super user"
    elsif status.to_s == "false"
      record_status = @user.save
      unless record_status
        if users.present?
          status = User.validate_for_error_messages(@user)
          error_message = User.return_error_message(@user) if status
        end
      end
      if error_message.present?
        flash[:alert] = error_message
      else
        flash[:notice] = flash_message(@user)
      end
    else
      super
    end
    if users.empty?
      flash_message(@user)
    end
    redirect_to view_path(status, @user)
  end

  private

  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  def flash_message(user)
    "#{ user.user_name } successfully logged in."
  end

  def view_path(status, user)
    (status.to_s == "true") ? "/users/sign_up" : '/projects'
  end
  
  def sign_up_params
    params.require(:user).permit(:user_id, :user_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:user_id, :user_name, :email, :password, :password_confirmation, :current_password)
  end
end