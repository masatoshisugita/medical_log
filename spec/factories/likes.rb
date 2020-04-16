FactoryBot.define do
  factory :like do
    association :user
    association :topic
  end
end
