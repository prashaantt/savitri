class BlogsController < ApplicationController

  before_filter :store_location
  before_filter :authenticate_user!, :except => [:show, :recentcomments, :recentposts]

  def index
    @blogs = current_user.cached_blogs
    authorize! :index, @blogs
  end

  def show
   blog = Blog.cached_find_by_slug(params[:id]) || not_found
   redirect_to blog_posts_path(blog), status: 301
  end

 def new
  @blog = Blog.new(:user_id=>current_user.id)
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
      format.json {render :json => @comments.to_json(:only =>[:commenter],:methods=>[:cached_share_url, :cached_post_title])}
    end
  end

  def recentposts
    blog = Blog.cached_find_by_slug(params[:blog_id])
    @posts = blog.cached_recentposts
    respond_to do |format|
      format.json {render :json => @posts.to_json(:only =>[:title],:methods=>[:cached_share_url])}
    end
  end

  def create
    @blog = current_user.blogs.build(params[:blog])
    authorize! :create, @blog
    respond_to do |format|
      if @blog.save
        format.html { redirect_to blogs_path, notice: 'blog was successfully created.' }
        format.js
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    raise CanCan::AccessDenied.new("Not authorized!", :update, Blog) unless current_user.admin?
    @blog = Blog.cached_find_by_slug(params[:id]) || not_found
    authorize! :edit, @blog
  end

  def update
    @blog = Blog.cached_find_by_slug(params[:id])
    authorize! :update, @blog

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to blogs_path, notice: 'blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/{slug}
  def destroy
    @blog = Blog.cached_find_by_slug(params[:id])
    authorize! :destroy, @blog
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_path, notice: 'blog was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def invite_for_posting
    @blog = Blog.cached_find_by_slug(params[:id])
    @users = []
    @blog.post_access.each do |id|
      @users << User.find(id)
      end
  end

  def send_write_posts_email
    @blog = Blog.find_by_slug(params[:id])
    @user = User.find_by_email(params[:blog][:post_access])
    if @user.nil?
      flash[:error] = "#{params[:blog][:post_access]} is not yet signed up"
      redirect_to invite_for_posting_path and return     
    elsif @blog.post_access.include?@user.id
      flash[:error] = "#{@user.username} already have access to this blog"
      redirect_to invite_for_posting_path and return
    else
      @blog.post_access.push(@user.id) unless @blog.post_access.include?@user.id
      authorize! :invite_for_posting, @blog
      @blog.save!
      PostAuthorEmailWorker.perform_async(@user.id, current_user.id, @blog.id)
    end
    flash[:notice] = "#{@user.username} now can write posts to #{@blog.title}"
    redirect_to blogs_path
  end
end
