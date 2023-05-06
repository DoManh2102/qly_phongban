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
      redirect_to user_path
    else
      flash[:danger] = "Error"
      redirect_to user_path
    end
  end

  private

  def user_param
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :birthday, :department)
  end
end
