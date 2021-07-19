class User < ApplicationRecord
  attr_accessor :reset_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :cart_items, -> { includes :product }

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }
  has_secure_password

  before_save :downcase_email, :capitalize_name

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_reset_digest
    self.reset_token = SecureRandom.urlsafe_base64
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def sent_reset_token
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    self.reset_sent_at < 3.hours.ago
  end

  def reset_authenticated?(token)
    return false if self.reset_digest.nil?
    BCrypt::Password.new(self.reset_digest).is_password?(token)
  end

  private def downcase_email
    self.email.downcase!
  end

  private def capitalize_name
    self.name.capitalize!
  end
end
