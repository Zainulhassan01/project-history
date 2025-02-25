class ProjectsController < ApplicationController
  before_action :set_user
  before_action :set_project, only: %i[show update]

  def index
    @projects = Project.all
  end

  def show
    @comments = @project.comments.includes(:user)
    @status_changes = @project.project_status_changes.includes(:user)
  end

  def update
    old_status = @project.status
    if @project.update(project_params)
      ProjectStatusChange.create!(
        project: @project,
        # we'll use the current user here but for now using the first user
        user: User.first,
        status: params[:status]
      )
      redirect_to @project, notice: "Project status updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def project_params
    params.require(:project).permit(:status)
  end
end
