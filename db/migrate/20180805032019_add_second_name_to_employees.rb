class AddSecondNameToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :second_name, :string
  end
end
