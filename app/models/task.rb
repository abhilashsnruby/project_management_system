class Task < ApplicationRecord
  belongs_to :project

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
    deadline_values = []
    priorities = task_params.select{ |k, v| k.include?("priority") }
    priorities.each do |key, value|
      deadline_values << eval(value)
    end
    deadline_values.flatten
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
end