class AddTaskIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :task_id, :integer
  end
end
