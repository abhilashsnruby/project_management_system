class SessionsController < Devise::SessionsController

  def new
    @user = User.new
  end

  def create
    logger.info "Attempt to sign in by #{ params[:user][:email] }"
    @user = User.find_by_email(params[:user][:email])
      if @user != nil
        @user.update(sign_in_params)
        flash[:notice] = "#{ @user.user_name } successfully logged in."
        redirect_to :controller => 'projects'
      else
        super
      end
  end
  
  private

  def sign_in_params
    params.require(:user).permit(:user_name, :email, :password, :remember_me)
  end

end