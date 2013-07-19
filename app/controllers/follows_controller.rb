class FollowsController < ApplicationController
 
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
  end
 
  def destroy
    @user = User.find(params[:id])
    current_user.stop_following(@user)
  end

end
