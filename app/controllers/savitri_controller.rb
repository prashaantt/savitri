# encoding: UTF-8
# SavitriController is Home Page
class SavitriController < ApplicationController
  def index
    @selections = Stanza.where(featured:true).sample(10)
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
