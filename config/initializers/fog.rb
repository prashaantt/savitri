CarrierWave.configure do |config|
  if Rails.env.production?
	config.fog_credentials = {
	  :provider               => 'AWS',                        # required
	  :aws_access_key_id      => 'AKIAJRJLL5KWIITWOWWA',                        # required
	  :aws_secret_access_key  => '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',                        # required
	  :region                 => 'ap-southeast-1'                  # optional, defaults to 'us-east-1'
	}
	config.fog_directory  = 'savitri-in-uploads'                     # required
	config.fog_public     = true                                   # optional, defaults to true
	config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  else
    config.fog_credentials = {
	  :provider               => 'AWS',                        # required
	  :aws_access_key_id      => 'AKIAJRJLL5KWIITWOWWA',                        # required
	  :aws_secret_access_key  => '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',                        # required
	  :region                 => 'ap-southeast-1'                  # optional, defaults to 'us-east-1'
	}
	config.fog_directory  = 'savitri-in-devuploads'                     # required
	config.fog_public     = true                                   # optional, defaults to true
	config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
end