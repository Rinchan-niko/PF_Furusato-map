class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :nickname, :profile_image, :email, :is_active)
  end

end
