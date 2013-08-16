class PostsController < ApplicationController

  before_filter :store_location
  before_filter :authenticate_user!, :except => [:show, :index]

  # GET /posts
  # GET /posts.json
  def index
    @blog_id  = Blog.cached_find_by_slug(params[:blog_id]).id
    @blogposts= Post.published.where(:blog_id=>@blog_id).order("posts.published_at DESC")
    if params[:tag]
      @tagposts = @blogposts.tagged_with(params[:tag])
      @posts    = @tagposts.page(params[:page]).per(10)
      @feedsrc  = @tagposts
      @tags     = @posts.tag_counts.order('tags_count desc').reject{|tag| tag.name.downcase == params[:tag].downcase}
                  .first(50).sort_by{|tag| tag.name.downcase} 
    else
      @posts    = @blogposts.page(params[:page]).per(10)
      @feedsrc  = @blogposts
      @tags     = @blogposts.tag_counts.order('tags_count desc').first(50).sort_by{|tag| tag.name.downcase}
    end
    #@post_years_reverse=@blogposts.group_by { |t| t.published_at.beginning_of_year }.sort.reverse.each
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
    @post = Post.cached_find_by_url(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new(:blog_id=>Blog.cached_find_by_slug(params[:blog_id]).id)
    authorize! :new, @post
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.cached_find_by_url(params[:id])
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    authorize! :create, @post

    if @post.published_at > Time.zone.now - 300
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
    @post = Post.cached_find_by_url(params[:id])
    @blog = Blog.cached_find_by_slug(params[:post][:blog_id])
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
