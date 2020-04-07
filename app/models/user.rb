class User < ApplicationRecord
  has_secure_password

  has_many :topics, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :user_image, UserImageUploader


  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォロワー取得
  #自分がフォローしている人 （中間テ−ブルは「follower」でソースのfollowed_idを参考にしてfollowing_userモデルにアクセスする）
  has_many :following_user, through: :follower,  source: :followed
  #自分をフォローしている人　（中間テ−ブルは「followed」でソースのfollower_idを参考にしてfollower_userモデルにアクセスする）
  has_many :follower_user, through: :followed,  source: :follower

  #other_userをフォローしているか確認する
  def following?(other_user)
    follower.find_by(followed_id: other_user.id)
  end

  #other_userをフォローする
  def follow(other_user)
    follower.create(followed_id: other_user.id)
  end

  #other_userのフォローを外す
  def unfollow(other_user)
    follower.find_by(followed_id: other_user.id).destroy
  end
end
