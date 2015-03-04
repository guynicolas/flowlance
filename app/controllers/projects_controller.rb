class ProjectsController < ApplicationController 
  before_filter :require_user
  def index
    @projects = current_user.projects.order("created_at DESC")
  end
  def new
    @project = Project.new 
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.status = "On Going"
    if @project.save
      flash[:success] = "You have successfully save a new project."
      Usermailer.send_email_on_new_project(@project.user, @project).deliver_now
      redirect_to home_path
    else 
      flash[:danger] = "Your project was not saved."
      render :new
    end 
  end

  def complete
    @project = Project.find(params[:id])
    @project.user = current_user
    @project.update_attribute(:status, "Completed")
    Usermailer.send_email_on_completed_project(@project.user, @project).deliver_now
    redirect_to home_path
  end

  private 

  def project_params
    params.require(:project).permit(:title, :description, :volume, :amount_due, :client_name, :status)
  end
end 