class Task < ApplicationRecord
  belongs_to :project

  def self.find_task_details params
    val = []
    task_params = params.permit(params.keys).to_h
    index = 0
    task_params.each do |key, value|
      if (key == "priority_#{index}")
        val << eval(task_params["priority_#{index}"])
      end
      index += 1 if (key == "priority_#{index}")
    end
    task = Task.where(id: params[:task])
    [task, val]
  end
end
