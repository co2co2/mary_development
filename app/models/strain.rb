class Strain < ApplicationRecord
	has_many :recipe
	has_and_belongs_to_many :effects
end
