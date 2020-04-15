class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validates :review,presence: true
end
