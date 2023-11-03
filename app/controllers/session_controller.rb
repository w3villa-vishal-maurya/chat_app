class SessionController < ApplicationController
  before_action :already_logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by username: params["sessions"]["username"]
    if @user && @user.authenticate(params["sessions"]["password"])
      flash[:success] = "Sucessfully Logged In"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Login failed!! check User Name and Password"
      render "new"
    end
  end

  def destroy
    # binding.pry
    session[:user_id] = nil
    flash[:notice] = "Logged Out Sucessfully"
    redirect_to login_path
  end

  private

  def already_logged_in_redirect
    if logged_in?
      flash[:alert] = "you are already logged in"
      redirect_to root_path
    end
  end
end
