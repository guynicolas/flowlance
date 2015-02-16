class Usermailer < ActionMailer::Base 
  default from: "info@flowlance.com"
  def send_welcome_email(user)
    @user = user 
    mail(to: @user.email, subject: "Welcome to Flowlance!" )
  end
end 