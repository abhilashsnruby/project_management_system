module ProjectsHelper
  
  def task_deadline
    ["one day", "two days", "three days"]
  end

  def all_project_users
    unless (User.count == 0)
      User.where('user_name IS NOT NULL').pluck(:user_name)
    end
  end

  def user_data(project, value)
    user = User.find(project.user_id)
    user_value = user.present? ? ((value == 'user_name') ? user.user_name : user.email) : ''
    user_value
  end

  def get_user_projects(value)
    User.find(value).projects.present?
  end

  # def give_table_space(value)
  #   value.times do
  #     if value == 3
  #       content_tag(:br)
  #     else
  #       content_tag(:td, value)
  #     end
  #   end
  # end
end