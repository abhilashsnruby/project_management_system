class AddHourToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :created_date_record, :datetime
  end
end
