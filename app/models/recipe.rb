class Recipe < ApplicationRecord
	has_many :instructions, dependent: :destroy
	has_many :reviews
	accepts_nested_attributes_for :instructions, allow_destroy: true

	has_many :measurements, dependent: :destroy
	has_many :ingredients, through: :measurements
	accepts_nested_attributes_for :measurements, :reject_if => :all_blank,
	:allow_destroy => true
	accepts_nested_attributes_for :ingredients

	belongs_to :user

end
