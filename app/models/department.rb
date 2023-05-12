class Department < ApplicationRecord
  has_many :users
  has_many :projects, dependent: :destroy

  belongs_to :leader, class_name: 'User', foreign_key: 'user_id', optional: true

  def is_leader?(user)
    # leader là đối tượng liên kết giữa Department và User, ở đây so sánh đối tượng leader với user
    leader == user
  end

  def member_department?(user)
    user.department_id == id
  end
end
