class PostsController < ApplicationController

  before_filter :store_location, :last_page
  before_filter :authenticate_user!, :except => [:show, :index, :archives]

  # GET /posts
  # GET /posts.json
  def index
    @per_page = 20
    blog_id  = Blog.cached_find_by_slug(params[:blog_id]) || not_found
    if params[:year]
       @blogposts = Post.filter(blog_id.id,params).order("posts.published_at DESC")
     else
       @blogposts = Post.published.where(:blog_id=>blog_id.id).order("posts.published_at DESC")
     end
    if params[:tag]
      @tagposts = @blogposts.tagged_with(params[:tag])
      @posts    = @tagposts.page(params[:page]).per(@per_page)
      @feedsrc  = @tagposts
      @tags     = @posts.tag_counts.order('tags_count desc').reject{|tag| tag.name.downcase == params[:tag].downcase || tag.name.start_with?("@")}
      .first(50).sort_by{|tag| tag.name.downcase}
    else
      @posts    = @blogposts.page(params[:page]).per(@per_page)
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
    @tags = @tags.select { |v| v.name =~ /#{query}/i }.reject { |v| v.name.start_with?("@")}
    respond_to do |format|
      format.json{ render :json => @tags.map(&:attributes) }
    end
  end

  def scheduled
    @per_page = 20
    @blog = Blog.cached_find_by_slug(params[:blog_id]) || not_found
    @blogposts = Post.cached_drafts(@blog.id)
    @posts = @blogposts.page(params[:page]).per(@per_page)
    if @posts.empty?
      @noscheduled = true;
    end
    authorize! :update, @blog
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    blog_id  = Blog.cached_find_by_slug(params[:blog_id]) || not_found
    @post = Post.cached_find_by_blog_id_and_url(blog_id.id,params[:id]) || not_found
    @related_posts = Sunspot.more_like_this(@post).results.first(5) rescue nil
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
    authorize! :edit, @post
    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @post }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(params[:post])

    unless params[:post][:series_title].strip.blank?
      series = "@" + params[:post][:series_title].to_url
      series_tag = Tag.find_or_create_by_name(series)
      @post.tag_list.add(series_tag.name)
    end

    authorize! :create, @post

    @post.update_draft_status(params)

    if(params[:size] == "now")
      @post.published_at = Time.zone.now
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to blog_post_path(@post.blog,@post), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        if @post.errors[:featured].present?
          flash.now[:error] = @post.errors[:featured].first
        end
        format.html { render 'posts/new'}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.cached_find_by_url(params[:id])
    
    #if not blank
      #if exists and changed: create new and remove existing
      #elsif doesn't exist: create new
      #else retain old
    #else if blank and exists: remove existing

    old_series_tag = @post.tag_list.select{|tag| tag.include?("@")}[0]

    params_tags = params[:post][:tag_tokens].split(",")
    
    if params[:post][:series_title].strip.blank?
      unless old_series_tag.nil?
        params_tags.delete(old_series_tag)
      end
    else
      new_series_tag = "@" + params[:post][:series_title].to_url
      if old_series_tag.nil?
        series = Tag.find_or_create_by_name(new_series_tag)
        params_tags << series.name
      elsif old_series_tag != new_series_tag
        params_tags.delete(old_series_tag)
        series = Tag.find_or_create_by_name(new_series_tag)
        params_tags << series.name
      else
        params_tags << old_series_tag
      end
    end

    params[:post][:tag_tokens] = params_tags.join(",")
    params[:post][:author_id] = @post.author_id

    authorize! :update, @post

    @post.delete_if_scheduled
    @post.update_draft_status(params)

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to blog_post_path(@post.blog,@post), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        if @post.errors[:featured].present?
          flash.now[:error] = @post.errors[:featured].first
        end
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

  def archives
    @blog = Blog.cached_find_by_slug(params[:blog_id]) || not_found
    @blogposts = Post.published.where(:blog_id=>@blog.id)
    .select("id, title, url, published_at")
    .order("posts.published_at DESC")
  end

  def update_featured_status
    @post = Post.cached_find_by_url(params[:post_id])
    @post.featured = (@post.featured == false)? true:false

    authorize! :update_featured_status, @post

    respond_to do |format|
      if @post.save
        format.js
      else
        if @post.errors[:featured].present?
          flash.now[:error] = @post.errors[:featured].first
        end
        format.js{ render 'cannot_featured', format: 'js'}
      end
    end    
  end
end
