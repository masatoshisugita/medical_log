FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    name "田中　太郎"
    sequence(:email) { |n|"tester#{n}@example.com"}
    password "abc123"
    password_confirmation "abc123"
  end
end
