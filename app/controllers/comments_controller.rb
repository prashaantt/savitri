class CommentsController < ApplicationController
  

  before_filter :authenticate_user!, :except => [:show, :index]
  load_and_authorize_resource 

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    redirect_to blog_post_path(@post.blog,@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_post_path(@post.blog,@post)
  end

end