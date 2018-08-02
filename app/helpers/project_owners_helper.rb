module ProjectOwnersHelper
  def fetch_users
    User.all.pluck(:user_name, :id)
  end

  def all_project_owner
    ProjectOwner.all.pluck(:project_owner_name, :id)
  end

  def fetch_user_name(project)
    user = User.find(project.user_id)
    user.present? ? user.user_name : "" 
  end
end