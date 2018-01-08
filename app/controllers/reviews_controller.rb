class ReviewsController < ApplicationController
	def create
    @review = Review.new
    @review.comment = params[:review][:comment]
    @review.recipe_id = params[:recipe_id]
    @review.user_id = current_user.id

    if @review.save
      redirect_back(fallback_location: 'recipes#show')
    else
      render 'recipes#show'
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
