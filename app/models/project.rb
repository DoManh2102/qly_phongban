class Project < ApplicationRecord
  belongs_to :department, optional: true
  has_many :user_projects
  has_many :users, through: :user_projects
  enum status: {Processing: false, Done: true}
end
