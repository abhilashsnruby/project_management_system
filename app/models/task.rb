class Task < ApplicationRecord
  belongs_to :project

  def self.find_task_details(params)
    val, priorities, deadlines = [], [], []
    task_params = retrive_parmas_keys(params)
    val << fetch_priority_values(task_params)
    priorities << task_priorities(val)
    deadlines << task_deadlines(params)
    task = Task.where(id: params[:task])
    [task, priorities.flatten, deadlines.flatten]
  end

  def self.fetch_priority_values(task_params)
    deadline_values = []
    priorities = task_params.select{ |k, v| k.include?("priority") }
    priorities.each do |key, value|
      deadline_values << eval(value)
    end
    deadline_values.flatten
  end

  def self.retrive_parmas_keys(params)
    params.permit(params.keys).to_h
  end

  def self.task_priorities(val)
    value = val.flatten
    value.map {|v| v.values }.flatten
  end

  def self.task_deadlines(params)
    task_params = retrive_parmas_keys(params)
    deadline = task_params.select{ |k, v| k.include?("deadline") }.values.flatten
    deadline.reject(&:empty?)
  end
end
