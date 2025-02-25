require 'rails_helper'

RSpec.describe ProjectStatusChange, type: :model do
  describe "associations" do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(pending: 0, in_progress: 1, completed: 2).backed_by_column_of_type(:integer) }
  end

  describe "callbacks" do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:status_change) { build(:project_status_change, project: project, user: user, status: "pending") }

    it "updates `status_updated_at` when status changes" do
      status_change.status = "in_progress"
      expect { status_change.save! }.to change { status_change.status_updated_at }
    end
  end

  describe "#prev_status" do
    it "returns the previous status correctly" do
      expect(ProjectStatusChange.new(status: "in_progress").prev_status).to eq("pending")
      expect(ProjectStatusChange.new(status: "completed").prev_status).to eq("in_progress")
      expect(ProjectStatusChange.new(status: "pending").prev_status).to eq("pending") # Default case
    end
  end
end
