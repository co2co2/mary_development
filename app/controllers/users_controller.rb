class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@fav_recipes = Recipe.user_favourites(params[:id])	
	end
end
