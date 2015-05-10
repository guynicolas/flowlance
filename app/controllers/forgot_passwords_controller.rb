class ForgotPasswordsController < ApplicationController 

  def create
    user = User.where(email: params[:email]).first
    if user
      Usermailer.send_forgot_password_email(user).deliver
      redirect_to forgot_password_confirmation_path
    else 
      if params[:email].blank? 
        flash[:danger] = "Email cannot be blank!"
      else  
        flash[:danger] = "This email was not found in our database. Please try again!" 
      end 
      redirect_to forgot_password_path
    end 
  end

end  