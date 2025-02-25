require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }

    context "with valid parameters" do
      it "creates a new comment" do
        expect {
          post :create, params: {
            user_id: user.id,
            project_id: project.id,
            comment: { content: "This is a comment." }
          }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the project page with a notice" do
        post :create, params: {
          user_id: user.id,
          project_id: project.id,
          comment: { content: "This is a comment." }
        }
        expect(response).to redirect_to(user_project_path(user, project))
        expect(flash[:notice]).to eq("Comment added.")
      end
    end

    context "with invalid parameters" do
      it "does not create a comment" do
        expect {
          post :create, params: {
            user_id: user.id,
            project_id: project.id,
            comment: { content: "" }
          }
        }.not_to change(Comment, :count)
      end

      it "renders the projects/show template with unprocessable entity status" do
        post :create, params: {
          user_id: user.id,
          project_id: project.id,
          comment: { content: "" }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template("projects/show")
      end
    end
  end
end
