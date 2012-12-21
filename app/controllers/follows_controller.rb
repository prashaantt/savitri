class FollowsController < ApplicationController

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
  end
 
  def destroy
    @user = User.find(params[:id])
    current_user.stop_following(@user)
  end

end
