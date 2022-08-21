class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w.]+@[\w]+\.[a-z]+\z/ }
  validates :nickname, presence: true, uniqueness: true, format: { with: /\A\w+\z/ }, length: { maximum: 40 }
  validates :header_color, format: { with: /\A#[0-9a-f]{6}\z/i }

  def link_name
    "@#{nickname}" if nickname.present?
  end

  private

  def downcase_nickname
    nickname.downcase! if nickname.present?
  end
end
