class ReviewsController < ApplicationController

  def favourite
    type = params[:type]
    if type == "favourite"
      @favourite = current_user.favourites.build(recipe_id: params[:recipe_id])
      @favourite.save
    else type == "unfavourite"
      @favourite = Favourite.where(user_id: current_user.id, recipe_id: params[:recipe_id])
      current_user.favourites.destroy(@favourite)
    end
    # redirect_back(fallback_location: 'recipes#show')
  end

	def create
    @recipe = Recipe.find(params[:recipe_id])
    @reviews = @recipe.reviews.order(created_at: :desc)
    @review = Review.new(review_params)
    @review.comment = params[:review][:comment]
    @review.recipe = @recipe
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { render partial: '/recipes/review', locals: {review: @review} }
      else
        redirect_to recipe_url(@recipe)
      end
    end


	end

	def edit

	end

	def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.find(params[:id])
    @review.destroy

    # respond_to do |format|
    #   format.html { redirect_to recipe_url(@recipe), notice: 'Review deleted.' }
    #   # format.js
    # end
	end

  def review_params
    params.require(:review).permit(:comment, :recipe_id, :user_id)
  end
end
