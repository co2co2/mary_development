class Instruction < ApplicationRecord
  validates :step, presence: true
  validates :step, length: { in: 6..2000 }
  belongs_to :recipe
end
