# encoding: UTF-8
# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_layout_variables

  def set_layout_variables
    @blogs = Blog.cached_all
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'Access denied!'
    redirect_to savitri_path
  end

  def store_location
    session[:resource_return_to] = request.fullpath
  end

  def last_page
    session[:last_page] = request.env['HTTP_REFERER']
  end

  def after_sign_in_path_for(resource)
    session[:resource_return_to] || savitri_path
  end

  def after_sign_out_path_for(resource_or_scope)
    savitri_path
  end

  def not_found
    fail ActionController::RoutingError.new('Couldn\'t find the page you were'\
        ' looking for.')
  end
end
