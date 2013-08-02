class PostsController < ApplicationController

  before_filter :store_location
  before_filter :authenticate_user!, :except => [:show, :index]

  # GET /posts
  # GET /posts.json
  def index
    @blog_id = Blog.find_by_slug(params[:blog_id]).id
    @blogposts = Post.published.where(:blog_id=>@blog_id).order("posts.published_at DESC")
    if params[:tag]
      @posts = @blogposts.tagged_with(params[:tag]).page(params[:page]).per(10)
    else
      @posts = @blogposts.page(params[:page]).per(10)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.atom { render :layout => false, :content_type=>"application/xml" }
      format.rss { redirect_to blog_posts_path(:format => :atom), :status => :moved_permanently }
      format.json { render json: @posts }
    end
  end

  def scheduled
    @blogposts = Post.draft.order('posts.published_at DESC')
    @posts = @blogposts.page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by_url(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
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
    @post = Post.find_by_url(params[:id])
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    authorize! :create, @post

    if @post.published_at > Time.now - 300
      #advanced / now posting. 5 minute min. difference
      @post.draft = true
    else 
      #Backdated posts
      @post.created_at = @post.published_at
      @post.draft = false
    end

    respond_to do |format|
      if @post.save
        
        if @post.draft?
          EmailWorker.perform_at(@post.published_at,current_user.id,@post.id)
        end

        format.html { redirect_to blog_posts_path(@post.blog), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render 'posts/new'}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find_by_url(params[:id])
    @blog = Blog.find_by_slug(params[:post][:blog_id])
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
    @post = Post.find_by_url(params[:id])
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_path(@post.blog) }
      format.json { head :no_content }
    end
  end

end
