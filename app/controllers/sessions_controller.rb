class SessionsController < ApplicationController 
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome to Flowlance!"
      redirect_to home_path
    else 
      redirect_to login_path
      flash[:danger] = "Your email and password don't match."
    end 
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are logged out."
    redirect_to root_path
  end
end 