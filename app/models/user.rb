class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :project_status_changes, dependent: :destroy
end
