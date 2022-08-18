class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w\d.]+@[\w\d]+\.[a-z]+\z/ }
  validates :nickname, presence: true, uniqueness: true, format: { with: /\A[\w\d]+\z/ }, length: { maximum: 40 }

  def downcase_nickname
    nickname.downcase!
  end
end
