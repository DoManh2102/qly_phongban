class Project < ApplicationRecord
  belongs_to :department, optional: true
  has_many :user_projects,  dependent: :destroy
  has_many :users, through: :user_projects # dependent: :destroy
  enum status: { Processing: false, Done: true }

  def member_project?(user)
    # users là đối tượng liên kết giữa model project và user
    users.include?(user)
  end

  # check current_user có phải là PM của project không
  def pm?(user)
    user_projects.where(is_leader: true).exists?(user_id: user)
  end
end
