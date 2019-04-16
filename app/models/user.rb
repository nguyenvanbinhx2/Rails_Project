class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :email_downcase

  validates :name,  presence: true, length: {maximum: Settings.name_max_length}
  validates :email, presence: true, length: {maximum: Settings.email_max_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.password_min_length}
  has_secure_password
  class << self
    def digest string
      if cost = ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create(string, cost: cost)
    end
  end

  private
  def email_downcase
    email.downcase!
  end
end
