class DepartmentsController < ApplicationController
  def index
    @departments = Department.paginate(page: params[:page], per_page: 10)
  end

  def show
    @department = Department.find(params[:id])
    @users = User.where(department_id: params[:id])
    @user_leader = User.find_by(id: @department.user_id)
    @project = Project.where(department_id: params[:id])
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(departments_param)
    if @department.save
      flash[:success] = "Create to Success!"
      redirect_to departments_path
    else
      byebug
      flash[:danger] = "Error"
      redirect_to action: :new
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(departments_param)
      redirect_to action: :index
      flash[:success] = "Update to Success!"
    else
      render action: :edit
      flash[:danger] = "Error!"
    end
  end

  def destroy
    @department = Department.find(params[:id])
  end



  def remove_user_from_department
    department = Department.find(department_id)
    user = department.user.find(user_id)
    user.destroy

    render action: :index
  end

  private

  def departments_param
    params.require(:department).permit(:name, :description, :user_id)
  end

end
