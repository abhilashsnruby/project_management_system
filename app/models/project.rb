class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def self.assign_tasks_to_project(params)
    tasks, val = Task.find_task_details(params)
    priorities = task_priorities(val)
    priorities.each do |priority|
      tasks.each do |task|
        task.project_id = params[:project]
        task.priority = priority
        task.save
      end
    end
  end

  def self.task_priorities(val)
    val.map {|v| v.values }.flatten
  end

end
