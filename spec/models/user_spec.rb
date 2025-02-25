require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:project_status_changes).dependent(:destroy) }
  end
end
