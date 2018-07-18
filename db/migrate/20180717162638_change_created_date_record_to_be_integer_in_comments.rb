class ChangeCreatedDateRecordToBeIntegerInComments < ActiveRecord::Migration[5.1]
  def change
    change_column :comments, :created_date_record, :integer
  end
end
