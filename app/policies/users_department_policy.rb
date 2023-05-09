class UsersDepartmentPolicy
  attr_reader :user, :department

  def initialize(user, department)
    @user = user
    @department = @department
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

end