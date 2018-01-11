class StrainsController < ApplicationController
	def index
		@strains = Strain.order(:name).where("name LIKE ?", "%#{params[:term]}%")
		render json: @strains.map(&:name)
	end
end
