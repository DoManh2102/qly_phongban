class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :department, optional: true
  has_many :user_projects
  has_many :projects, through: :user_projects
  enum role: {admin: 1, hr: 2, employee: 3}

end
