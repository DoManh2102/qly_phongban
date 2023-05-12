class User < ApplicationRecord
  extend FriendlyId
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  friendly_id :slug_candidates, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :department, optional: true #, dependent: :destroy
  has_many :user_projects , dependent: :destroy
  has_many :projects, through: :user_projects
  enum role: { admin: 1, hr: 2, employee: 3 }

  before_destroy :check_user_projects

  validates :name, presence: true, length: { maximum: 30 }

  validates :email, presence: true,
            length: { maximum: 50 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true

  private

  def slug_candidates
    "#info"
  end

  def check_user_projects
    if user_projects.exists?
      errors.add(:base, "This user has related user projects. Please delete them first.")
      throw :abort
    end
  end
end
