class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :delete_all
  # has_many :asked_questions, class_name: 'Question', foreign_key: :author_id

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w.]+@[\w]+\.[a-z]+\z/ }
  validates :nickname, presence: true, uniqueness: true, format: { with: /\A\w+\z/ }, length: { maximum: 40 }
  validates :header_color, format: { with: /\A#[0-9a-f]{6}\z/i }

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
