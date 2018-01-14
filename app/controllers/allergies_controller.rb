class AllergiesController < ApplicationController
	def show
    	@allergy = Allergy.find(params[:id])
  	end
end
