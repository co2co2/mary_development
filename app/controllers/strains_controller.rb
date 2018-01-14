class StrainsController < ApplicationController
  def index
        @strains = Strain.order(:name).where("name LIKE ?", "%#{params[:term]}%")
        strain_hash = {}
        @strains.each do |strain|
        strain_hash[strain.id] = strain.name
        end
        render json: strain_hash
    end
end
