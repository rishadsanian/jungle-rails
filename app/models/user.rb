class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true
  
  def self.authenticate_with_credentials (email, password)
    user = find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end

  end

end
