class StrainsController < ApplicationController
  def index
    @strains = Strain.get_names(params[:term])
        strain_hash = {}
        @strains.each do |strain|
        strain_hash[strain.id] = strain.name
        end
        render json: strain_hash
    end
end
