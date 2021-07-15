class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)
    if @user.save
      flash[:success] = "User registered"
      redirect_to "/"
    else
      render "new"
    end
  end

  def user_create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
