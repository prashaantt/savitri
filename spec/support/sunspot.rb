# encoding: utf-8
require 'sunspot/rails/spec_helper'

Spec::Runner.configure do |config|
  config.before(:each) do
    ::Sunspot.session = ::Sunspot::Rails::StubSessionProxy.new(::Sunspot.session)
  end

  config.after(:each) do
    ::Sunspot.session = ::Sunspot.session.original_session
  end
end
Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
