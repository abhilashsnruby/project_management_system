class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def self.assign_tasks_to_project(params)
    tasks, priorities, deadlines, status = Task.find_task_details(params)
    binding.pry
    tasks.each do |task|
      priorities.each do |priority|
        deadlines.each do |deadline|
          status.each do |status|
            task.project_id = params[:project]
            task.priority = priority
            task.deadline = deadline
            task.status = status
            task.save
          end
        end
      end
    end
  end

end
