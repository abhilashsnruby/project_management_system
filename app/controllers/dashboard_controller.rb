class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @projects = Project.all
    @tasks = Task.all
    @user = User.all
    @loged_in_user = current_user
    if @loged_in_user.present?
      @user_name = @loged_in_user.attributes['user_name']
      @user_email = @loged_in_user.attributes['email']
      @user_projects = @loged_in_user.projects
    end
  end

end