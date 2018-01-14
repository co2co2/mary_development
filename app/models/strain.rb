class Strain < ApplicationRecord
	has_many :recipe
	has_and_belongs_to_many :effects
  	accepts_nested_attributes_for :effects

  scope :get_names, ->(input) { order(:name).where("name ILIKE ?", "%#{input}%")}
end
