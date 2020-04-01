class Topic < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  def nice(user)
    likes.create(user_id: user.id)
  end

  def no_nice(user)
    likes.find_by(user_id: user.id)
  end
end
