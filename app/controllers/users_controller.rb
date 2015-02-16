class UsersController < ApplicationController 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Usermailer.send_welcome_email(@user).deliver_now
      redirect_to login_path 
    else 
      flash[:danger] = "Please correct the errors."
      render :new
    end 
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end 