class User < ApplicationRecord
  has_secure_password
  has_many_attached :files
  has_many :shared_file_associations
  validates :user_name, :first_name, :email, :password_digest, presence: true
  validates :user_name, length: { maximum: 15 }, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, length: { minimum: 8 }
  validates :password_digest, format: {
    with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*/,
    message: 'Password must contain atleast one uppercase, lowercase and number'
  }
end
