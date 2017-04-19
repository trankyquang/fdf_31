class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :suggestings, dependent: :destroy
  has_many :ratings, dependent: :destroy

  mount_uploader :avatar, UserUploader

  validates :user_name, presence: true,
    length: {minimum: Settings.validation.user_name_min,
      maximum: Settings.validation.user_name_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.validation.email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.validation.password}, allow: nil

  has_secure_password

  before_save {email.downcase!}

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end
end
