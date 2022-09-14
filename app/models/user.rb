class User < ApplicationRecord
  include Gravtastic

  has_secure_password
  has_many :questions, dependent: :delete_all

  before_validation :downcase_nickname
  after_commit :update_posted_questions, on: :update, if: :saved_change_to_nickname?

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w.]+@[\w]+\.[a-z]+\z/ }
  validates :nickname, presence: true, uniqueness: true, format: { with: /\A\w+\z/ }, length: { maximum: 40 }
  validates :header_color, format: { with: /\A#[0-9a-f]{6}\z/i }

  gravtastic(secure: true, filetype: [:png, :jpg], size: 100, default: 'retro')

  def to_param
    nickname
  end

  private

  def downcase_nickname
    nickname&.downcase!
  end

  def update_posted_questions
    Question.where(user: self).update_all(user_nickname: nickname)
  end
end
