class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def self.assign_tasks_to_project(params)
    tasks, priorities, deadlines, status = Task.find_task_details(params)
    Task.save_task_priority_details(tasks, priorities, params)
    Task.save_task_deadlines_details(tasks, deadlines, params)
    Task.save_task_status_details(tasks, status, params)
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
