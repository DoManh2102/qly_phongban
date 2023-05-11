class ProjectPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?
    user.present? || project.member_project?(user) || project.department&.is_leader?(user)
  end

  def show?
    # current_user là: admin? || member_project? || leader department của project
    user.admin? || project.member_project?(user) || project.department&.is_leader?(user)
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
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