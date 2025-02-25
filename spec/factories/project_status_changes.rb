FactoryBot.define do
  factory :project_status_change do
    status { "pending" }
    association :project
    association :user
  end
end
