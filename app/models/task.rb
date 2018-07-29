class Task < ApplicationRecord
  resourcify
  belongs_to :project
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.find_task_details(params)
    priority_val, status_val, priorities, deadlines, status = [], [], [], [], []
    task_params = retrive_parmas_keys(params)
    priority_val << fetch_priority_status_values(task_params)
    priorities << task_priorities(priority_val)
    deadlines << task_deadlines(params)
    status_val << fetch_status_values(task_params)
    status << task_status(status_val)
    task = Task.where(id: params[:task])
    [task, priorities.flatten, deadlines.flatten, status.flatten]
  end

  def self.fetch_priority_status_values(task_params)
    priority_values = []
    priorities = task_params.select{ |k, v| k.include?("priority") }
    priorities.each do |key, value|
      priority_values << eval(value)
    end
    priority_values.flatten
  end

  def self.fetch_status_values(task_params)
    status_values = []
    status = task_params.select{ |k, v| k.include?("status") }
    status.each do |key, value|
      status_values << eval(value)
    end
    status_values.flatten
  end

  def self.retrive_parmas_keys(params)
    params.permit(params.keys).to_h
  end

  def self.task_priorities(val)
    value = val.flatten
    value.map {|v| v.values }.flatten
  end

  def self.task_status(val)
    value = val.flatten
    value.map {|v| v.values }.flatten
  end

  def self.task_deadlines(params)
    task_params = retrive_parmas_keys(params)
    deadline = task_params.select{ |k, v| k.include?("deadline") }.values.flatten
    deadline.reject(&:empty?)
  end

  def self.save_task_priority_details(tasks, priorities, *args)
    index = 0
    tasks.each do |task|
      if tasks.count == priorities.count
        task.project_id = args[0][:project].to_i
        task.priority = priorities[index]
        task.save
        index += 1
      end
    end
  end

  def self.save_task_deadlines_details(tasks, deadlines, *args)
    index = 0
    tasks.each do |task|
      if tasks.count == deadlines.count
        task.project_id = args[0][:project].to_i
        task.deadline = deadlines[index]
        task.save
        index += 1
      end
    end
  end

  def self.save_task_status_details(tasks, status, *args)
    index = 0
    tasks.each do |task|
      if tasks.count == status.count
        task.project_id = args[0][:project].to_i
        task.status = status[index]
        task.save
        index += 1
      end
    end
  end
end