class Question < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :author, class_name: 'User', optional: true

  validates :body, presence: true, length: { maximum: 280 }
  validates :user_id, presence: true
end
