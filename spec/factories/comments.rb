FactoryBot.define do
  factory :comment do
    review "私も同じ病気になりました。お互いがんばりましょう！"
    association :user
    association :topic
  end
end
