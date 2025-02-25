class ProjectStatusChange < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum status: { pending: 0, in_progress: 1, completed: 2 }, _default: :pending

  scope :latest_status_change, -> { order(created_at: :desc).limit(1) }


  before_save :update_status_timestamp
  validate :status_cannot_change_from_completed

  def prev_status
    # getting previous status basis on the enum hash, assuming that values will be changed in ascending order
    ProjectStatusChange.statuses.key(ProjectStatusChange.statuses[status.to_sym]-1) || "pending"
  end

  private

  def update_status_timestamp
    self.status_updated_at = Time.current
  end

  def status_cannot_change_from_completed
    if last_persisted_status == "completed" && status_changed?
      errors.add(:status, "cannot be changed from completed")
    end
  end

  def last_persisted_status
    project.project_status_changes.where.not(id: nil).last.status
  end
end
