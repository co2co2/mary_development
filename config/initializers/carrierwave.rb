# config/initializers/carrierwave.rb
CarrierWave.configure do |config|

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

end
