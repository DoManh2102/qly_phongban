class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :status, default: false
      t.integer :department_id, null: true
      t.foreign_key :departments, foreign_key: true
      t.timestamps
    end
  end
end
