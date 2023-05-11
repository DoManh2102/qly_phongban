class UserController < ApplicationController
  rescue_from ActiveRecord::InvalidForeignKey do |exception|
    flash[:alert] = "Error! Unable to delete Parts due to foreign key binding!"
    redirect_to user_index_path
  end

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
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
    authorize @user
    if @user.destroy
      flash[:success] = "Destroy user Success!"
      redirect_to user_index_path
    else
      flash[:error] = @user.errors.full_messages.join(". ")
      redirect_to user_index_path
    end
  end

  def edit_info
    @user = User.find(params[:id])
    # authorize @user
  end

  def update_info
    @user = User.find(params[:id])
    # authorize @user
    if @user.update(edit_info_params)
      redirect_to user_path(@user)
      flash[:success] = "User info was successfully updated."
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
    # authorize @user
  rescue
    flash[:danger] = "Can't edit"
    redirect_to user_index_path
  end

  def update
    role_value = 1 if user_params[:role] == "admin"
    role_value = 2 if user_params[:role] == "hr"
    role_value = 3 if user_params[:role] == "employee"

    @user = User.find(params[:id])
    # authorize @user

    if @user.update(role: role_value, name: user_params[:name])
      redirect_to user_index_path
      flash[:success] = "Update to Success!"
    else
      redirect_to user_index_path
      flash[:danger] = "Error! Update false"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :birthday, :department, :role)
  end

  def edit_info_params
    params.require(:user).permit(:name, :address, :birthday)
  end
end
