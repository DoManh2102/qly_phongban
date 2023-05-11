class UsersDepartmentController < ApplicationController
  def edit
    @department = Department.find(params[:department_id])
    # các user chưa có phòng ban và các user thuộc phòng ban đó
    @users = User.where(department_id: nil).or(User.where(department_id: @department.id))

    @users_department = @department.users # user của department
    # @user_ids_in_department = @department.user_ids
    authorize @department
  end

  def update
    @department = Department.find(params[:department_id]) # info department

    # Cập nhật department_id cho các user được chọn
    User.where(id: user_department_params[:user_ids]).update_all(department_id: @department.id)

    # Xóa department_id cho các user không được chọn
    if user_department_params[:user_ids] == [""]
      # khi xóa user là leader thì user_id trong department = nil
      @department.users.all.each do |user|
        if user.id == @department.user_id
          @department.update(user_id: nil)
        end
        user.update(department_id: nil)
      end
    else
      @department.users.all.each do |user|
        if user.id == @department.user_id
          @department.update(user_id: nil)
        end
      end
      @department.users.where.not(id: user_department_params[:user_ids]).update_all(department_id: nil)
    end

    redirect_to department_path(@department)
    flash[:success] = "Update to Success!"
  end

  private

  def user_department_params
    params.require(:department).permit(user_ids: [])
  end
end
