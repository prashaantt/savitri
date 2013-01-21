class BlogsController < ApplicationController
  def index
  	@posts = Blog.find(1).posts
  end

  def latest
  end
end
