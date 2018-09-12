class ProjectOwner < ApplicationRecord
  has_many :projects
  belongs_to :user
  # set per_page globally

  def self.save_project_owner_details(params)
    projects = params['owner_projects']['project'][0].values
    owner_id = params[:project_owner]
    projects = Project.where(title: projects)
    projects.each do |project|
      project.update_attributes(project_owner_id: owner_id)
    end
    projects
  end

  def self.search(params)
    project_owners = params[:search].present? ? ProjectOwner.search_query(params) : ProjectOwner.all
    project_owners
  end

  def self.search_query(params)
    ProjectOwner.where("project_owner_name like ?", "%#{params[:search]}%")
  end
end
