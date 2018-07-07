class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def self.assign_tasks_to_project(params)
    tasks, priorities, deadlines = Task.find_task_details(params)
    priorities.each do |priority|
      deadlines.each do |deadline|
        tasks.each do |task|
          task.project_id = params[:project]
          task.priority = priority
          task.deadline = deadline
          task.save
        end
      end
    end
  end

end
