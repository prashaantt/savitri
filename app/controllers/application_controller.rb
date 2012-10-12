class ApplicationController < ActionController::Base
  protect_from_forgery
 
  def store_location
      session[:resource_return_to] = request.fullpath
  end

  def after_sign_in_path_for(resource)
    session[:resource_return_to] || super
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
 
end
