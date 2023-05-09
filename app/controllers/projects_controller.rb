class ProjectsController < ApplicationController
  rescue_from ActiveRecord::InvalidForeignKey do |exception|
    redirect_to projects_path, alert: "Error! Unable to delete Parts due to foreign key binding!"
  end
  def index
    @projects = Project.all
    authorize @projects
  end

  def show
    @project = Project.find(params[:id])
    @users_project = UserProject.where(project_id: params[:id])
    authorize @project
    # lấy ra mảng user là leader và thuộc project
    @users_leader = UserProject.where(project_id: @project.id, is_leader: true)
  end

  def new
    @departments = Department.all
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_param)
    authorize @project
    if @project.save
      flash[:success] = "Create to Success!"
      redirect_to projects_path
    else
      flash[:danger] = "Error"
      redirect_to action: :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    # byebug
    @project = Project.find(params[:id])
    authorize @project
    if @project.update(project_param)
      redirect_to action: :index
      flash[:success] = "Update to Success!"
    else
      render action: :edit
      flash[:danger] = "Error!"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project
    if @project.destroy
      flash[:success] = 'Project was successfully deleted.'
    else
      flash[:error] = 'Unable to delete Parts due to foreign key binding'
    end
    redirect_to projects_path
  end


  private

  def project_param
    params.require(:project).permit(:name, :department_id, :status).tap do |whitelisted|
      whitelisted[:status] = params[:project][:status].to_s == "true" ? true : false
    end
  end
end
