# encoding: UTF-8
# Authentication model.
class Authentication < ActiveRecord::Base
  attr_accessible :name, :oauth_secret, :oauth_token, :provider, :uid
  belongs_to :user
  def tweet(tweet)
    Twitter.configure do |config|
      config.consumer_key       = ENV['TWITTER_KEY']
      config.consumer_secret    = ENV['TWITTER_SECRET']
      config.oauth_token        = oauth_token
      config.oauth_token_secret = oauth_secret
    end
    Twitter.update(tweet)
  end
end
