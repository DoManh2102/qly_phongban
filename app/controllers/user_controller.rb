class UserController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    p @user
    if @user.save
      flash[:success] = "Create to Success!"
      redirect_to user_index_path
    else
      flash[:alert] = @user.errors.full_messages.join('. ')
      redirect_to user_index_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to user_index_path
      flash[:success] = "Destroy user Success!"
    else
      redirect_to user_index_path
      flash[:danger] = "Error! Destroy false"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    role_value = 1 if user_param[:role] == "admin"
    role_value = 2 if user_param[:role] == "hr"
    role_value = 3 if user_param[:role] == "employee"

    @user = User.find(params[:id])
    if @user.update(role: role_value)
      redirect_to user_index_path
      flash[:success] = "Update to Success!"
    else
      redirect_to user_index_path
      flash[:danger] = "Error! Update false"
    end
  end

  private

  def user_param
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :birthday, :department, :role)
  end
end
