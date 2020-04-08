class Topic < ApplicationRecord
  belongs_to :user
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
