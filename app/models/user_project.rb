class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum is_leader: { employee: false, PM: true }

end
