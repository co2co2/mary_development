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

    if @review.save

      respond_to do |format|
        format.html do
          redirect_to @review.recipe
        end

        format.json { render json: @review }
      end

    else
      if user_signed_in?
        if Favourite.exists?(user_id: current_user.id, recipe_id: params[:recipe_id])
          @favourite_link = "unfavourite"
        else
          @favourite_link = "favourite"
        end
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
