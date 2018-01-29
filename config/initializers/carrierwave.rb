CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV['AWSAccessKeyId'],            # required
    :aws_secret_access_key  => ENV['AWSSecretKey'],     # required
    :region                 => 'us-east-2',                        # optional, defaults to 'us-east-1'
    # :host                   => "https://s3-us-east-1.amazonaws.com"
  }
  config.fog_directory  = 'marybitmaker'              # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
#
# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/aws'                        # required
#   config.fog_credentials = {
#     provider:              'AWS',                        # required
#     aws_access_key_id:     'xxx',                        # required
#     aws_secret_access_key: 'yyy',                        # required
#     region:                'eu-west-1',                  # optional, defaults to 'us-east-1'
#     host:                  's3.example.com',             # optional, defaults to nil
#     endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
#   }
#   config.fog_directory  = 'name_of_directory'                                   # required
#   config.fog_public     = false                                                 # optional, defaults to true
#   config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
# end
