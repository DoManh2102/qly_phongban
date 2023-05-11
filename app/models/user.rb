class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :department, optional: true #, dependent: :destroy
  has_many :user_projects #, dependent: :destroy
  has_many :projects, through: :user_projects
  enum role: { admin: 1, hr: 2, employee: 3 }

  before_destroy :check_user_projects

  private

  def check_user_projects
    if user_projects.exists?
      errors.add(:base, "This user has related user projects. Please delete them first.")
      throw :abort
    end
  end
end
