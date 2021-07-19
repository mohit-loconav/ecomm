class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # forwading_url = session[:forwading_url]
      log_in(user)
      flash[:success] = "logged in successfully"
      redirect_to category_path
      # redirect_to forwading_url || user_path(user)
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
