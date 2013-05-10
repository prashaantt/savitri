class UploadsController < ApplicationController

  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end

  def create
    puts params.inspect
    @upload = Upload.new(params[:upload])
    
    respond_to do |format|
      if @upload.save
        format.js
        format.json { render json: @upload, status: :created, location: @upload }
      else
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end
end
