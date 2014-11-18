# encoding: UTF-8
# SavitriController is Home Page
class SavitriController < ApplicationController
  def index
    @selections = Stanza.where(featured:true).sample(10)
    @posts_1 = @blog_1.posts.where(featured: false).published.order('published_at DESC').limit(5)
    @posts_2 = @blog_2.posts.where(featured: false).published.order('published_at DESC').limit(5)
    @posts_3 = @blog_3.posts.where(featured: false).published.order('published_at DESC').limit(5)
  end

  def show
    @sentence = Stanza.random
    @text = []
    @sentence.cached_lines.each do |l|
      @text << l.line
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        render json: { text: @text,
                       source: @sentence.section.to_s + '.' +
                               @sentence.runningno.to_s }
      end
    end
  end
end
