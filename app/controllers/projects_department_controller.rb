class ProjectsDepartmentController < ApplicationController
  def edit
    @department = Department.find(params[:department_id])
    # lấy ra projects có department_id: nil và project thuộc department hiện tại
    @projects = Project.where(department_id: nil).or(Project.where(department_id: @department.id))
    @projects_department = @department.projects
  end

  def update
    @department = Department.find(params[:department_id]) # info department
    puts "============================"
    p projects_department_params[:project_ids]

    # Cập nhật department_id cho các project được chọn
    Project.where(id: projects_department_params[:project_ids]).update_all(department_id: @department.id)

    # Xóa department_id cho các project không được chọn
    if projects_department_params[:project_ids] == [""]
      @department.projects.all.update_all(department_id: nil)
    else
      @department.projects.where.not(id: projects_department_params[:project_ids]).update_all(department_id: nil)
    end

    redirect_to department_path(@department)
    flash[:success] = "Update to Success!"
  end

  private

  def projects_department_params
    params.require(:department).permit(project_ids: [])
  end

end
