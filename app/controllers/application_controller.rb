class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to savitri_path
  end

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
