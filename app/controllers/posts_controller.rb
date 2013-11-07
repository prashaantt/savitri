class PostsController < ApplicationController

  before_filter :store_location, :last_page
  before_filter :authenticate_user!, :except => [:show, :index]

  # GET /posts
  # GET /posts.json
  def index
    blog_id  = Blog.cached_find_by_slug(params[:blog_id]) || not_found
    @blogposts= Post.published.where(:blog_id=>blog_id.id).order("posts.published_at DESC")
    if params[:tag]
      @tagposts = @blogposts.tagged_with(params[:tag])
      @posts    = @tagposts.page(params[:page]).per(10)
      @feedsrc  = @tagposts
      @tags     = @posts.tag_counts.order('tags_count desc').reject{|tag| tag.name.downcase == params[:tag].downcase || tag.name.start_with?("@")}
      .first(50).sort_by{|tag| tag.name.downcase}
    else
      @posts    = @blogposts.page(params[:page]).per(10)
      @feedsrc  = @blogposts
      @tags     = @blogposts.tag_counts.order('tags_count desc').reject{|tag| tag.name.start_with?("@")}.first(50).sort_by{|tag| tag.name.downcase}
    end
    #@post_years_reverse=@blogposts.group_by { |t| t.published_at.beginning_of_year }.sort.reverse.each
    respond_to do |format|
      format.html # index.html.erb
      format.atom { render :layout => false, :content_type=>"application/xml" }
      format.rss { redirect_to blog_posts_path(:format => :atom), :status => :moved_permanently }
      format.json { render json: @posts }
    end
  end

  def tags
    query = params[:q]
    if query[-1,1] == " "
      #query = query.gsub(" ", "")
      Tag.find_or_create_by_name(query)
    end

    #Do the search in memory for better performance

    @tags = ActsAsTaggableOn::Tag.all
    @tags = @tags.select { |v| v.name =~ /#{query}/i }
    respond_to do |format|
      format.json{ render :json => @tags.map(&:attributes) }
    end
  end

  def scheduled
    @blog_id  = Blog.cached_find_by_slug(params[:blog_id]).id
    @blogposts = Post.cached_drafts(@blog_id)
    @posts = @blogposts.page(params[:page]).per(10)
    if @posts.empty?
      @noscheduled = true;
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    blog_id  = Blog.cached_find_by_slug(params[:blog_id]) || not_found
    @post = Post.cached_find_by_blog_id_and_url(blog_id.id,params[:id])
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
    blog_id  = Blog.cached_find_by_slug(params[:blog_id]) || not_found
    @post = Post.cached_find_by_blog_id_and_url(blog_id.id,params[:id])
    unless @post.tag_list.empty?
      @post.tag_list = @post.tag_list.reject{|tag| tag.start_with?("@")}
    end
    authorize! :edit, @post
    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @post }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    if params[:post][:series_title]
      series = params[:post][:series_title].parameterize
      params[:post][:tag_list] += ", @" + series
    end
    authorize! :create, @post

    @post.update_draft_status(params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to blog_post_path(@post.blog,@post), notice: 'Post was successfully created.' }
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
    if params[:post][:series_title] && (params[:post][:series_title] != @post.series_title || @post.tag_list.select{|tag| tag.start_with?("@")}[0].nil?)
      series = params[:post][:series_title].parameterize
      params[:post][:tag_tokens] += ", @" + series
    end
    authorize! :update, @post

    @post.delete_if_scheduled
    @post.update_draft_status(params)

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

    @post.delete_if_scheduled
    @post.destroy
    
    respond_to do |format|
      format.html { redirect_to blog_posts_path(@post.blog) }
      format.json { head :no_content }
    end
  end

end
