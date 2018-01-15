class StrainsController < ApplicationController
  def index
    @strains = Strain.get_names(params[:term])
    strain_hash = {}
    @strains.each do |strain|
      strain_hash[strain.id] = strain.name
    end
    render json: strain_hash
  end

  def show

      @strain = Strain.find(params[:id])
      @positives = Strain.positive_effects(@strain.id)
      @negatives = Strain.negative_effects(@strain.id)
      @medicals = Strain.medical_effects(@strain.id)

  end

  def map

  end
end
