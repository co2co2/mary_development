class ReviewsController < ApplicationController
	def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(review_params)
    @review.comment = params[:review][:comment]
    @review.recipe = @recipe
    @review.user_id = current_user.id

    if @review.save
      redirect_to @review.recipe
    else
      if Favourite.exists?(user_id: current_user.id, recipe_id: params[:id])
        @favourite_link = "unfavourite"
      else
        @favourite_link = "favourite"
      end
      render '/recipes/show'
    end

	end

	def edit

	end

	def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_back(fallback_location: 'recipes#show')

	end

  def review_params
    params.require(:review).permit(:comment, :recipe_id, :user_id)
  end
end
