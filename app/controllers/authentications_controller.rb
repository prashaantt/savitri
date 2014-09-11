# encoding: UTF-8
# AuthenticationsController is for adding social sites for a user
class AuthenticationsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!

  def index
    if current_user
      @authentications = current_user.authentications.group_by(&:provider)
    end
    flash['error'] = params['message']
    authorize! :read, Authentication
  end

  def create
    if request.env['omniauth.auth']
      omniauth = request.env['omniauth.auth']
      authentication = current_user.authentications.find_by_provider_and_uid(
                       omniauth['provider'], omniauth['uid'])
      if authentication
        flash[:notice] = 'Already authorized.'
        redirect_to authentications_url
      elsif current_user
        current_user.authentications.create!(provider: omniauth['provider'],
          uid: omniauth['uid'], name: omniauth['info']['name'],
          oauth_token: omniauth['credentials']['token'],
          oauth_secret: omniauth['credentials']['secret'])
        flash[:notice] = 'Authentication successful.'
        redirect_to authentications_url
      end
    else
      flash[:error] = 'We are not able to authenticate you. Please try later.'
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = 'Successfully destroyed authentication.'
    redirect_to authentications_url
  end
end
