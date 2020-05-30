# frozen_string_literal: true

class Relationship < ApplicationRecord
  # フォローする人は「follower」、フォローされる人は「followed」
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :follower_id, uniqueness: { scope: :followed_id }
end
