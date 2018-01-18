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
    @location = params[:current_address]
    @distance = params[:km]
  end

  def dispensaries
    @location = params[:current_address]
    @distance = params[:km]
    @dispensaries = []

    if @location.empty? || @distance.empty?
      flash[:alert] = 'Please try again!'
      redirect_to search_dispensaries_url
    else
    search_string = @location.split(' ').join('+')

    res = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=weed+dispensaries&location=#{Geocoder.coordinates(@location).join(',')}&key=AIzaSyBt-nsAkbJPsjhTlA2IyNzXSKaHFeCvbQU")

    body = JSON.parse(res.body)

    body['results'].each do |result|
      hasher = {name: result['name'], address: result['formatted_address'], location: result['geometry']['location']}
      hasher[:distance] = Geocoder::Calculations.distance_between(hasher[:location].values, Geocoder.coordinates(@location)).round(2)

      if @distance.to_i > hasher[:distance]
        @dispensaries << hasher
      end

    end

    @dispensaries.sort_by! do |dispensary|
      dispensary[:distance]
    end

    end
  end

  def cod_to_address
    render json: { address: Geocoder.search(params[:lat]+","+params[:long]).first.address.to_s}
  end



end
