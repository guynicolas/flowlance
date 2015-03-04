class Usermailer < ActionMailer::Base 
  default from: "info@flowlance.com"
  def send_welcome_email(user)
    @user = user 
    mail(to: @user.email, subject: "Welcome to Flowlance!" )
  end

  def send_email_on_new_project(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "You have successfully created a new project.")
  end

  def send_email_on_completed_project(user, project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "You have successfully completed a project.")
  end
end 