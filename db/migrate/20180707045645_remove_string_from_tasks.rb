class RemoveStringFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :string, :string
  end
end
