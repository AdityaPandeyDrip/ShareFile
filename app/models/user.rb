class User < ApplicationRecord
  has_secure_password
  has_many_attached :files
  validates :user_name, :first_name, :email, presence: true
  validates :user_name, length: { maximum: 15 }, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8, maximum: 15 }
  validates :password, format: {
    with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*/,
    message: 'Password must contain atleast one uppercase, lowercase and number'
  }
end
