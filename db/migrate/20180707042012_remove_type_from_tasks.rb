class RemoveTypeFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :type, :string
  end
end
