class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@favourites = @user.favourites
		@recipes = @user.recipes
		@fav_recipes = []
		@favourites.each do |favourite|
			@fav_recipes << Recipe.find(favourite.recipe_id)
		end
	end
end
