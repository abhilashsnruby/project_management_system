class ProjectOwner < ApplicationRecord
  has_many :projects
  
  def self.save_project_owner_details(params)
    projects = params['owner_projects']['project'][0].values
    owner_id = params[:project_owner]
    projects = Project.where(title: projects)
    projects.each do |project|
      project.update_attributes(project_owner_id: owner_id)
    end
    projects
  end
end
