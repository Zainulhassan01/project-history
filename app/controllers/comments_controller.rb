class CommentsController < ApplicationController
  def create
    @project = Project.find_by(id: params[:project_id])
    @comment = @project.comments.build(comment_params.merge(user: @current_user))

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_project_path(@project.user, @project), notice: "Comment added." }
        format.turbo_stream
      end
    else
      render "projects/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
