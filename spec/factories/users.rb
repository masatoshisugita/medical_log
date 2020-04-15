FactoryBot.define do
  factory :user do
    name "田中　太郎"
    sequence(:email) { |n|"tester#{n}@example.com"}
    password "abc123"
    password_confirmation "abc123"
  end
end
