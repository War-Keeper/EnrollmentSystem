class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer
    add_column :users, :user_id, :string
    add_index :users, :user_id, unique: true
    add_column :users, :name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :phone_number, :string
    add_column :users, :department, :string
    add_column :users, :major, :string
  end
end
