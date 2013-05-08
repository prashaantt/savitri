class PostsController < ApplicationController

  before_filter :store_location
  before_filter :authenticate_user!, :except => [:show, :index, :latest]

  #load_and_authorize_resource
  # load_resource / authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    @blog_id = Blog.find_by_slug(params[:blog_id]).id
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).where(:blog_id=>@blog_id).page(params[:page]).per(5)
    else
      @posts = Post.where(:blog_id=>@blog_id).order("created_at DESC").page(params[:page]).per(5)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.atom { render :layout => false }
      format.rss { redirect_to blog_posts_path(:format => :atom), :status => :moved_permanently }
      format.json { render json: @posts }
    end
  end

  def latest
    @posts = Post.order("created_at DESC").limit(4)
    #client = YouTubeIt::Client.new(:dev_key => "AI39si46cUDp-C9EgXCdXZk3zwArq-lZwEDhmscmsAYeQmU-2UOiYXw9LlkmnJw5OyAbtT3-m4VtVcmdUPwN0DJyV4f3ceDFyg")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    puts @post.inspect
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    puts params.inspect
    @post = Post.new(:blog_id=>Blog.find_by_slug(params[:blog_id]).id)
    #logger.info "count is"+@counter.count
    authorize! :new, @post
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.json
  def create
    puts params.inspect
    @post = Post.new(params[:post])
    #@blog=Blog.find_by_slug(params[:post].first[:blog_id])
    #@post.blog_id = @blog.id   
    #@post = @blog.build(params[:post])
    #@blog = current_user.blogs.build(params[:blog])
    #@post = @blog.posts.build(params[:post])
    authorize! :create, @post
    respond_to do |format|
      if @post.save
        #EmailWorker.perform_async(current_user.id)
        format.html { redirect_to blog_posts_path(@post.blog), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render 'posts/new'}
        #format.html { render new_blog_post_path(@post.blog) }
        #format.html { redirect_to new_blog_post_path(:blog_id => Blog.find_by_id(@slug).slug,) }
        #format.html { redirect_to blog_posts_path(Blog.find(params[:post][:blog_id])) }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @blog=Blog.find_by_slug(params[:post][:blog_id])
    authorize! :update, @post
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to blog_post_path(@post.blog,@post), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_path(@post.blog) }
      format.json { head :no_content }
    end
  end

end
