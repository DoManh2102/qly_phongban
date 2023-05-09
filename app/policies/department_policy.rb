class DepartmentPolicy
  attr_reader :user, :department

  def initialize(user, department)
    @user = user
    @department = department
  end

  def index?
    user.present?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin? || @department.is_leader?(user)
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end