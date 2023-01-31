class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user.nil? || !user.authenticate(password)
      nil
    else
      user
    end
  end
end