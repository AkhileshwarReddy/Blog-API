class User < ApplicationRecord
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email is not valid" }

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :phone_number, presence: true, uniqueness: true
end
