class UsersDepartmentController < ApplicationController
  def edit
    @department = Department.find(params[:department_id])
    # các user chưa có phòng ban và các user thuộc phòng ban đó
    @users = User.where(department_id: nil).or(User.where(department_id: @department.id))

    @users_department = @department.user # user của department
    @user_ids_in_department = @department.user_ids
  end

  def update
    @department = Department.find(params[:department_id]) # info department

    # Cập nhật department_id cho các user được chọn
    User.where(id: user_department_params[:user_ids]).update_all(department_id: @department.id)

    # Xóa department_id cho các user không được chọn
    if user_department_params[:user_ids] == [""]
      @department.user.all.update_all(department_id: nil)
    else
      @department.user.where.not(id: user_department_params[:user_ids]).update_all(department_id: nil)
    end

    redirect_to department_path(@department)
    flash[:success] = "Update to Success!"
  end

  private

  def user_department_params
    params.require(:department).permit(user_ids: [])
  end
end