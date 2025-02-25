FactoryBot.define do
  factory :project do
    name { "Sample Project" }
    association :user
  end
end
