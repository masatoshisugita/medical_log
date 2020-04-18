FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    name "田中　太郎"
    sequence(:email) { |n|"tester#{n}@example.com"}
    user_image File.open(File.join(Rails.root, 'spec/files/test_file.jpg'))
    password "abc123"
    password_confirmation "abc123"
    activated false
    activated_at nil
  end

  # factory :other_user, aliases: [:follower, :followed] do
  #   name "山田　次郎"
  #   sequence(:email) { |n|"#{n}tester@example.com"}
  #   user_image File.open(File.join(Rails.root, 'spec/files/test_file.jpg'))
  #   password "abc123"
  #   password_confirmation "abc123"
  #   activated false
  #   activated_at nil
  # end

  #無効になっている
    trait :invalid do
      name nil
    end
  #アカウントが有効化になっていない
    trait :invalid_activated do
      activated false
    end
end
