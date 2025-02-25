require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:project_status_changes).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "callbacks" do
    let(:user) { create(:user) }

    it "creates a project status change after creation" do
      project = create(:project, user: user)
      expect(project.project_status_changes.count).to eq(1)
      expect(project.project_status_changes.first.status).to eq("pending")
    end
  end

  describe "#latest_status" do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }

    context "when no status changes exist" do
      it "returns 'pending'" do
        expect(project.latest_status).to eq("pending")
      end
    end

    context "when status changes exist" do
      before do
        create(:project_status_change, project: project, user: user, status: "in_progress")
      end

      it "returns the most recent status" do
        expect(project.latest_status).to eq("in_progress")
      end
    end
  end
end
