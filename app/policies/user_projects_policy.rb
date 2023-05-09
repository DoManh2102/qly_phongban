class UserProjectsPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def new?
    user.admin? || project.pm?(user)
  end

  def create?
    user.admin? || project.pm?(user)
  end

  def edit?
    p project.department.is_leader?(user)
    user.admin? || project.department.is_leader?(user)
  end

  def update?
    user.admin? || project.department.is_leader?(user)
  end

  def destroy?
    user.admin? || project.department.is_leader?(user)
  end
end