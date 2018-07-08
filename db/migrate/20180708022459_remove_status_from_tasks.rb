class RemoveStatusFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :status, :boolean
  end
end
