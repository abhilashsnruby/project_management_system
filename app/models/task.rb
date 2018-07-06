class Task < ApplicationRecord
  belongs_to :project

  def self.find_task_details params
    Task.where(id: params[:task])
  end
  
end
