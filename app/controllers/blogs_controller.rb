# encoding: UTF-8
# BlogsController
class BlogsController < ApplicationController
  before_filter :store_location, except: [:recentcomments, :recentposts]
  before_filter :authenticate_user!, except:
                [:show, :recentcomments, :recentposts]

  def index
    @blogs = current_user.cached_blogs
    authorize! :index, @blogs
  end

  def show
    blog = Blog.cached_find_by_slug(params[:id]) || not_found
    redirect_to blog_posts_path(blog), status: 301
  end

  def new
    @blog = Blog.new(user_id: current_user.id)
    authorize! :create, @blog
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  def recentcomments
    blog = Blog.cached_find_by_slug(params[:blog_id])
    @comments = blog.cached_recentcomments
    respond_to do |format|
      format.json do
        render json: @comments.to_json(methods:
        [:commenter, :cached_share_url, :cached_post_title])
      end
    end
  end

  def recentposts
    blog = Blog.cached_find_by_slug(params[:blog_id])
    @posts = blog.cached_recentposts
    respond_to do |format|
      format.json do
        render json: @posts.to_json(only: [:title],
                                    methods: [:cached_share_url])
      end
    end
  end

  def create
    @blog = current_user.blogs.build(params[:blog])
    authorize! :create, @blog
    respond_to do |format|
      if @blog.save
        format.html do
          redirect_to blogs_path, notice: 'blog was successfully created.'
        end
        format.js
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: 'new' }
        format.json do
          render json: @blog.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def edit
    @blog = Blog.cached_find_by_slug(params[:id]) || not_found
    authorize! :edit, @blog
  end

  def update
    @blog = Blog.cached_find_by_slug(params[:id])
    authorize! :update, @blog

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html do
          redirect_to blogs_path, notice: 'blog was successfully updated.'
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json do
          render json: @blog.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /blogs/{slug}
  def destroy
    @blog = Blog.cached_find_by_slug(params[:id])
    authorize! :destroy, @blog
    @blog.destroy

    respond_to do |format|
      format.html do
        redirect_to blogs_path, notice: 'blog was successfully deleted.'
      end
      format.json { head :no_content }
    end
  end

  def authorized_users
    @blog = Blog.cached_find_by_slug(params[:id])
    @users = []
    @blog.post_access.each do |id|
      @users << User.find(id)
    end
    authorize! :authorized_users, @blog
  end

  def invite_for_blog
    p @blog = Blog.cached_find_by_slug(params[:id])
    p @user = User.find_by_username(params[:blog][:post_access])
    @blog.post_access || []
    if @user.nil?
      flash[:error] = "#{params[:blog][:post_access]} is not yet signed up"
      redirect_to authorized_users_path and return
    elsif @user.admin?
      flash[:error] = "#{@user.username} is Admin or Head. And already has"\
      "access to any blog"
      redirect_to authorized_users_path and return
    elsif @blog.post_access.include?@user.id
      flash[:error] = "#{@user.username} already has access to this blog"
      redirect_to authorized_users_path and return
    else
      @blog.post_access.push(@user.id)
      authorize! :invite_for_blog, @blog
      @blog.save!
      InviteForBlogWorker.perform_async(@user.id, current_user.id, @blog.id)
    end
    flash[:notice] = "#{@user.username} can now write posts to #{@blog.title}"
    redirect_to authorized_users_path
  end

  def remove_blog_access
    blog = Blog.cached_find_by_slug(params[:slug])
    blog.post_access.delete(params[:user_id].to_i)
    blog.save!
    render nothing: true
  end
end
