class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :project_status_changes, dependent: :destroy

  validates :name, presence: true

  after_create :create_project_status

  def latest_status
    project_status_changes.latest_status_change.pick(:status) || "pending"
  end

  private

  def create_project_status
    # we'll use the current user here but for now using the first user
    project_status_changes.create!(status: :pending, user: User.first)
  end
end
