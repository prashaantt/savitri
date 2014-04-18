require "sunspot/rails/solr_logging"
if Rails.env.staging?
  Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
end
