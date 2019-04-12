class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :email_downcase

  validates :name,  presence: true, length: {maximum: Setting.name_max_length}
  validates :email, presence: true, length: {maximum: Setting.email_max_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Setting.password_min_length}
  has_secure_password

  private
  def email_downcase
    email.downcase!
  end
end
