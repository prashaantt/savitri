class HealthController < ApplicationController

  def ping
  	render :text => :ok.to_s, :status => :ok, :content_type => Mime::TEXT
  end

end
