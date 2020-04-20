class Topic < ApplicationRecord
  belongs_to :user

  validates :sick_name, presence: true, length: { maximum: 30 }
  validates :period, length: { maximum: 20 }
  validates :initial_symptom, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.searching(sick_name)
    if sick_name
      Topic.where(['sick_name LIKE ?',"%#{sick_name}%"])  
    end
  end
end
