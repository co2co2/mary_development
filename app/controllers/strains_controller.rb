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

  def search_dispensaries
    @location = params[:search]
    @distance = params[:miles]
  end

  def dispensaries
    @location = params[:search]
    @distance = params[:miles]
    @dispensaries = Dispensary.geocoded.near(@location, @distance, :order => 'distance')

    if @location.empty? || @distance.empty?
      flash[:alert] = 'Please try again!'
      redirect_to search_dispensaries_url
    elsif @distance.to_i < 0
      flash[:alert] = "Distance can't be negative!"
      redirect_to search_dispensaries_url
    end

  end



end
