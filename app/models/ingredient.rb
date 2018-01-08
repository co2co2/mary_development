class Ingredient < ApplicationRecord
  has_many :recipes, through: :measurements
  has_many :measurements, dependent: :destroy


end
