class Instruction < ApplicationRecord
  validates :step, presence: true
  validates :step, length: { in: 6..120 }
  belongs_to :recipe
end
