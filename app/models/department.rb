class Department < ApplicationRecord
  has_many :users
  has_many :projects

  belongs_to :leader, class_name: 'User', foreign_key: 'user_id'
  def is_leader?(user)
    #leader là đối tượng liên kết giữa Department và User, ở đây so sánh đối tượng leader với current_
    leader == user
  end

end
