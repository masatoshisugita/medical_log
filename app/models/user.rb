# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  attr_accessor :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  has_many :topics, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :user_image, UserImageUploader

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy # フォロー取得
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy # フォロワー取得
  # 自分がフォローしている人 （中間テ−ブルは「active_relationships」でソースのfollowed_idを参考にしてfollowing_userモデルにアクセスする）
  has_many :following_user, through: :active_relationships,  source: :followed
  # 自分をフォローしている人　（中間テ−ブルは「passive_relationships」でソースのfollower_idを参考にしてfollower_userモデルにアクセスする）
  has_many :follower_user, through: :passive_relationships,  source: :follower

  # other_userをフォローしているか確認する
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  # other_userをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # other_userのフォローを外す
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # トピックをイイねする
  def favorite(topic)
    Like.create!(user_id: id, topic_id: topic.id)
  end

  # トピックのイイねを解除する
  def unfavorite(topic)
    Like.find_by(user_id: id, topic_id: topic.id).destroy
  end

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
