class AddProjectOwnerIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :project_owner_id, :integer
  end
end
