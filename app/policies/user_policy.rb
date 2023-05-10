class UserPolicy
  attr_reader :user, :project

  def initialize(user, user_select)
    @user = user
    @user_select = user_select
  end

  def index?
    user.present?
  end

  def show?
    user.admin? || user.hr? || user == @user_select || user.id == @user_select.department.user_id #user là leader của user_select
  end

  def new?
    user.admin?
  end

  def create
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