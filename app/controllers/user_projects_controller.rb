class UserProjectsController < ApplicationController
  def index
    @users = UserProject.where(project_id: id)
  end

  def new
    @project = Project.find(params[:project_id])
    @user_project = UserProject.new
    # users không thuộc project và department_id != nil
    @users_not_project = User.where.not(id: @project.users.pluck(:id)).where.not(department_id: nil)
    @users_to_project = UserProject.where(project_id: params[:project_id]) # users thuộc project
    # authorize @project
    authorize @project, policy_class: UserProjectsPolicy
  end

  def create
    @project = Project.find(params[:project_id])
    user_project_params[:user_id].each do |user_id|
      UserProject.create(user_id: user_id,
                         project_id: user_project_params[:project_id],
                         start_date: user_project_params[:start_date],
                         end_date: user_project_params[:end_date])
    end
    authorize @project, policy_class: UserProjectsPolicy
    redirect_to project_path(user_project_params[:project_id])
    flash[:success] = "Create to Success!"
  end

  def edit
    @project = Project.find(params[:project_id])
    @user_project = UserProject.find(params[:id])
    @user = User.friendly.find(params[:format])
    @user_to_project = UserProject.where(user_id: @user.id, project_id: params[:project_id])
    puts "============"
    p @user_to_project
    authorize @project, policy_class: UserProjectsPolicy
  end

  def update
    @project = Project.find(params[:project_id])
    @user_project = UserProject.find(params[:id])
    authorize @project, policy_class: UserProjectsPolicy

    is_leader = user_project_params[:is_leader].include?(@user_project.user_id.to_s) ? true : false

    if @user_project.update(is_leader: is_leader)
      redirect_to project_path(params[:project_id])
      flash[:success] = "Update to Success!"
    else
      render action: :edit
      flash[:danger] = "Error!"
    end
  end

  def destroy
    # current_user.projects.find(params[:id])
    # Project.find(params[:id])

    @project = Project.find(params[:project_id])
    @user_project = UserProject.find(params[:id])
    puts "======================"
    @pm_users_project = UserProject.where(project_id: params[:project_id], is_leader: 'PM')
    @users_project = UserProject.where(project_id: params[:project_id])


    if @pm_users_project.length > 0 && @pm_users_project.length <= 1 && @user_project.is_leader == "PM"
      flash[:danger] = t('activerecord.errors.messages.min_1_pm')
      redirect_to project_path(params[:project_id])
      authorize @project, policy_class: UserProjectsPolicy
    else
      @user_project.destroy
      redirect_to project_path(params[:project_id])
      flash[:success] = "Delete user project to Success!"
      authorize @project, policy_class: UserProjectsPolicy
    end
  end

  def user_project_params
    params.require(:user_project).permit(:start_date, :end_date, :project_id, :is_leader, user_id: [])
  end
end
