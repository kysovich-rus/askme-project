class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w.]+@[\w]+\.[a-z]+\z/ }
  validates :nickname, presence: true, uniqueness: true, format: { with: /\A\w+\z/ }, length: { maximum: 40 }

  # validates :header_color, format: { with: /\A\w+\z/}, length: { is: 6 }

  def link_name
    "@#{nickname}"
  end

  private

  def downcase_nickname
    nickname.downcase!
  end
end
