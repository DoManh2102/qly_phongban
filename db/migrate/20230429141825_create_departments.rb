class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.text :description
      t.integer :user_id, null: true
      t.foreign_key :users, foreign_key: true
      t.timestamps
    end
  end
end
