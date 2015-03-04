class UsersController < ApplicationController 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      Stripe.api_key = "sk_test_6RimonauC3QoCduloAkYnfKe"
      charge = StripeWrapper::Charge.create(
        :amount => 2000,
        :card => params[:stripeToken],
        :description => "Sign Up Charge for #{@user.email}"
      ) 
      if charge.successful? 
        @user.charge_token = charge.charge_token        
        @user.save
        Usermailer.send_welcome_email(@user).deliver_now
        redirect_to login_path 
      else 
        flash[:danger] = charge.error_message
        render :new
      end  
    else 
      flash[:danger] = "Please correct the errors."
      render :new
    end 
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :admin, :charge_token)
  end
end 