# encoding: UTF-8
# Comment controller.

class CommentsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @post = Post.cached_find_by_url(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    respond_to do |format|
      if @comment.save
        CommentWorker.perform_async(@comment.user_id, @comment.id)
        format.html { redirect_to blog_post_path(@post.blog, @post),
                      notice: 'Comment was successfully created.' }
      else
        flash[:error] = 'Comment can\'t be blank'
        format.html { redirect_to blog_post_path(@post.blog, @post) }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    respond_with_bip @comment
  end

  def destroy
    @post = Post.find_by_url(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_post_path(@post.blog, @post)
  end
end
