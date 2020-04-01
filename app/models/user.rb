class User < ApplicationRecord
  has_secure_password

  has_many :topics, dependent: :destroy
  has_many :likes, dependent: :destroy
end
