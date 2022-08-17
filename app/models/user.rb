class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: /[\w\d]+@[a-z]+\.[a-z]+/ }
  validates :nickname, presence: true, uniqueness: true, format: { with: /[\w\d]+/ }

  def downcase_nickname
    nickname.downcase!
  end
end
