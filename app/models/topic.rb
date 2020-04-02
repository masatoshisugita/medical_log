class Topic < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :nice_users, through: :likes, source: :user

  def nice(user)
    likes.create(user_id: user.id)
  end

  def no_nice(user)
    likes.find_by(user_id: user.id)
  end

  def nice?(user)
    nice_users.include?(user)
  end
end
