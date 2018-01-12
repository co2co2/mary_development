class Review < ApplicationRecord
  validates :comment, presence: true
  validates :comment, length: { in: 6..500 }
	belongs_to :user
	belongs_to :recipe
end
