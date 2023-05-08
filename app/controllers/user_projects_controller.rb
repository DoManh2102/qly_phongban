class UserProjectsController < ApplicationController
  def index
    @users = UserProject.where(project_id: id)
  end

  def new
    @project = Project.find(params[:project_id])
    @user_project = UserProject.new
  end

  def create
    user_project_params[:user_id].each do |user_id|
      UserProject.create(user_id: user_id,
                         project_id: user_project_params[:project_id],
                         start_date: user_project_params[:start_date],
                         end_date: user_project_params[:end_date])
    end
    redirect_to projects_path(user_project_params[:project_id])
    flash[:success] = "Create to Success!"
  end

  def edit
    @project = Project.find(params[:project_id])
    @user_project = UserProject.find(params[:id])
    @user_to_project = UserProject.where(user_id: params[:format], project_id: params[:project_id])
    puts '------------------------------------------------------'
    p @user_to_project
    puts '------------------------------------------------------'
  end

  def update
    @user_project = UserProject.find(params[:id])
    is_leader = user_project_params[:is_leader].include?(@user_project.user_id.to_s) ? true : false

    if @user_project.update(is_leader: is_leader)
      redirect_to project_path(params[:project_id])
      flash[:success] = "Update to Success!"
    else
      render action: :edit
      flash[:danger] = "Error!"
    end
  end

  def user_project_params
    params.require(:user_project).permit(:start_date, :end_date, :project_id, :is_leader, user_id: [])
  end
end
