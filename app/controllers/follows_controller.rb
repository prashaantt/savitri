# encoding: UTF-8
# FollowsController is for following users and blogs

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

  def follow_blog
    @blog = Blog.find(params[:blog_id])
    current_user.follow(@blog)
    respond_to do |format|
      format.js
    end
  end

  def unfollow_blog
    @blog = Blog.find(params[:blog_id])
    current_user.stop_following(@blog)
    respond_to do |format|
      format.js
    end
  end
end
