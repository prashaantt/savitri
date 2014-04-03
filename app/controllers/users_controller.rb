class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  load_and_authorize_resource
  
  def index
    authorize! :index, @users
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id]) || not_found

    base_url = request.protocol + request.host_with_port
    @feed_url = base_url + user_path(params[:id]) + "/feed"

    @series = {}

    @feedsrc = []

    @user_comments = @user.comments
    @user_notebooks = @user.notebooks
    user_posts = @user.cached_recent_posts
    @user_blogs_with_posts = []
    user_posts.group_by(&:blog_id).each do |blog_id,posts|
      @user_blogs_with_posts << [Blog.select('id, title, slug').find(blog_id), posts]
    end
    user_posts.each do |post|
      series = post.tag_list.select{|tag| tag.match(/^@/)}[0]
      @feedsrc << post
      unless series.nil?
        @series[post.id] = { :name => series, :title => post.series_title, :blog_id => post.blog.id, :blog_title => post.blog.title,
                                       :published => post.published_at }        
      end 
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      format.atom { render :layout => false, :content_type=>"application/xml" }
      format.rss { redirect_to blog_posts_path(:format => :atom), :status => :moved_permanently }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id]) || not_found
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
