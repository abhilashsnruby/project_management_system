class Project < ApplicationRecord
  resourcify
  has_many :tasks, dependent: :destroy
  belongs_to :user
  belongs_to :project_owner

  def self.assign_tasks_to_project(params) 
    tasks, priorities, deadlines, status = Task.find_task_details(params)
    Task.save_task_priority_details(tasks, priorities, params)
    Task.save_task_deadlines_details(tasks, deadlines, params)
    Task.save_task_status_details(tasks, status, params)
  end

  def self.assign_projects_to_users(params)
    user_projects = params['user_projects']['project'][0].values
    user_id = User.find_by_user_name(params['user_name']).id
    projects = Project.where(title: user_projects)
    projects.each do |project|
      project.update_attributes(user_id: user_id)
    end
    projects
  end
  
  # def self.prgrub
  #   binding.pry
  #   a = [12,21,12,1]
  #   numbers = []
  #   a.each_with_index do |num, index|
  #     binding.pry
  #     if (a[index] > a[index + 1])
  #       numbers << a[index + 1]
  #     else
  #       numbers << a[index]
  #     end
  #   end
  # end

end