CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        				  # required
    :aws_access_key_id      => 'AKIAIILBLZ2OJVD56EIQ',                        # required
    :aws_secret_access_key  => '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',    # required
  }
  config.fog_directory  = 'failboard'                     # required
  config.fog_public     = false                                   # optional, defaults to true
end