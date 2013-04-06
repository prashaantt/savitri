class UploadsController < ApplicationController

  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section }
    end
  end

  def create
    puts params.inspect
    @upload = Upload.new(params[:upload])

    respond_to do |format|
      if @upload.save
        format.js
        format.json { render json: @section, status: :created, location: @section }
      else
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end
end
