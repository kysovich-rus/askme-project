class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /[\w\d]+@[a-z]+\.[a-z]+/ }
  validates :nickname, presence: true, uniqueness: true, format: { with: /[\w\d]+/ }
end
