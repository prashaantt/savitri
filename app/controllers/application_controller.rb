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

  helper_method :javascript_include_view_js 

  #http://stackoverflow.com/a/12903463/156775
  def javascript_include_view_js
      if FileTest.exists? "app/assets/javascripts/"+params[:controller]+".js.coffee"
        if params[:controller].to_s == 'read'
          unless current_user.nil?
            return '<script src="/assets/'+params[:controller]+'.js.coffee" type="text/javascript"></script>'   
          end
        else
          return '<script src="/assets/'+params[:controller]+'.js.coffee" type="text/javascript"></script>' 
        end
          
      end
  end
 
end
