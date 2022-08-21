class Question < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :author, class_name: 'User', optional: true

  validates :body, presence: true, length: { maximum: 280 }
end
