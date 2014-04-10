# encoding: UTF-8
# SavitriController is Home Page
class SavitriController < ApplicationController
  def index
    @posts = Post.where(featured: true).published.order('published_at DESC')
    if @posts.count < 5
      temp = Post.where(featured: false).published.order('published_at DESC')
      .limit(5 - @posts.count)
      @posts += temp
    end
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
