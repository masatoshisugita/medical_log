# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :review, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true
  validates :topic_id, presence: true
end
