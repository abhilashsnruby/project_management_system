class SearchesController < ApplicationController
  respond_to :js
  
  def search_projects_data
    if params['data'].present?
      if params['data'] == "Project"
        @project_details, @tasks, @users = Project.retrive_complete_project_details()
      elsif params['data'] == "Employee"
        @employees, @users = Employee.retrive_complete_employee_details()
      elsif params['data'] == "User"
        @users, @employees, @projects = User.retrive_complete_user_details()
      end
    end
  end
end