class User < ApplicationRecord
  has_secure_password

  has_many :topics, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: follower_id, dependent: :destroy #フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: followed_id, dependent: :destroy　#フォロワー取得
  has_many :following_user, through: :follower,  source: :followed #自分がフォローしている人
  has_many :follower_user, through: :followed,  source: :follower #自分をフォローしている人
end
