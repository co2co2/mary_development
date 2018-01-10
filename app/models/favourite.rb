class Favourite < ApplicationRecord
	belongs_to :user
	belongs_to :recipe

	scope :user_favourites, -> {joins(:recipe).where("favourites.user_id IS 1")}
end
