module DashboardHelper

  def user_projects(projects)
    projects.present? ? projects.count : 0
  end

  def user_name_detail(user_name)
    user_name.present? ? user_name : ''
  end
end
