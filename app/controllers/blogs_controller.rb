class BlogsController < ApplicationController


	def home
		@posts = Blog.find_by_id(1).posts.limit(3)
	end

	def latest
	end

	def index
		 @blogs = current_user.blogs
	end

	def show
	puts params.inspect
	@posts = Blog.find_by_slug(params[:id]).posts
	end

	def new
     @blog = Blog.new
     respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
 	 end
	end

	def create
		#@blog = Blog.new(params[:blog])
		@blog = current_user.blogs.build(params[:blog])

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
		@blog = Blog.find_by_slug(params[:id])
	end


  def update
    @blog = Blog.find_by_slug(params[:id])

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
end