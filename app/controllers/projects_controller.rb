class ProjectsController < ApplicationController 
  before_filter :require_user
  def index
    @projects = current_user.projects
  end
  def new
    @project = Project.new 
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:success] = "You have successfully save a new project."
      redirect_to home_path
    else 
      flash[:danger] = "Your project was not saved."
      render :new
    end 
  end

  private 

  def project_params
    params.require(:project).permit(:title, :description, :volume, :amount_due, :client_name)
  end
end 