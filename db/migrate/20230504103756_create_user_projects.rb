class CreateUserProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :user_projects do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :user_id_leader
      t.string :start_date
      t.string :end_date
      t.foreign_key :users, foreign_key: true
      t.foreign_key :projects, foreign_key: true
      t.timestamps
    end
  end
end
