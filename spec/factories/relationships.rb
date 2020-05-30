# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    association :follower
    association :followed
  end
end
