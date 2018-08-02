class CreateProjectOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :project_owners do |t|
      t.string :project_owner_name
      t.string :qualification
      t.integer :user_id

      t.timestamps
    end
  end
end
