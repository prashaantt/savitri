if Rails.env.staging?
  uri = URI.parse('redis://redistogo:59cef3ebb640bb3ef3d33cfeccce2b72@barreleye.redistogo.com:11346/')
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
