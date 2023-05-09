class AddDepartmentIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :department, null: true, foreign_key: true
  end
end
