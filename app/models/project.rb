class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def self.assign_tasks_to_project(params)
    tasks = Task.find_task_details(params)
    tasks.each do |task|
      task.project_id = params[:project]
      task.save
    end
  end

end
