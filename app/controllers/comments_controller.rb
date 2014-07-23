# encoding: UTF-8
# Comment controller.

class CommentsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!, :except => [:notify]
  load_and_authorize_resource :except => [:notify]

  def create
    @post = Post.cached_find_by_url(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    CommentWorker.perform_async(@comment.user_id, @comment.id)
    redirect_to blog_post_path(@post.blog, @post)
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    respond_with @comment
  end

  def destroy
    @post = Post.find_by_url(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_post_path(@post.blog, @post)
  end

  def notify
    current_user_id = current_user.id rescue nil
    puts "REMOTE_HOST: "
    puts request.remote_host
    puts "CURRENT_HOST: "
    puts request.host
    #CommentWorker.perform_async(current_user_id, params)
    render nothing: true
  end
end
