class UserProjectsController < ApplicationController
  def index
    @users = UserProject.where(project_id: id)
  end

  def new
    @project = Project.find(params[:project_id])
    @user_project = UserProject.new
  end

  def create
    puts '------------------------------------------------'
    p user_project_params
    puts '------------------------------------------------'

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
    
  end

  def user_project_params
    params.require(:user_project).permit(:start_date, :end_date, :project_id, user_id: [])
  end
end
