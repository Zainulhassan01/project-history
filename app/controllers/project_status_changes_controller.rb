class ProjectStatusChangesController < ApplicationController
  before_action :set_user
  before_action :set_project

  def create
    @status_change = @project.project_status_changes.build(status_change_params)
    @status_change.user = @current_user
    if @status_change.save
      redirect_to user_project_path(@user, @project), notice: "Project status updated."
    else
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_project
    @project = @user.projects.find_by(id: params[:project_id])
  end

  def status_change_params
    params.require(:project_status_change).permit(:status)
  end
end
