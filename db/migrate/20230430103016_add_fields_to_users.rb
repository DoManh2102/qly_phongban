class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :birthday, :string
    # add_column :users, :department_id, :integer, null: true
    add_column :users, :role, :integer, default: 3
  end
end
