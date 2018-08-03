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
    if current_user.roles.pluck(:name).include?('admin') == true
      redirect_to '/admin'
    else
      render template: 'dashboard/index'
    end
  end

end