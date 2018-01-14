class Ingredient < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  has_many :recipes, through: :measurements
  has_many :measurements, dependent: :destroy


end
