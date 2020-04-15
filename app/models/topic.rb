class Topic < ApplicationRecord
  belongs_to :user

  validates :sick_name, presence: true, length: { maximum: 30 }
  validates :period, length: { maximum: 20 }
  validates :initial_symptom, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.search(search)
    if search
      Topic.where(['sick_name LIKE ?',"%#{search}%"])
    else
      Topic.all
    end
  end
end
