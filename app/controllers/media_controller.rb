class MediaController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /media
  # GET /media.json
  def index
    authorize! :create, @media
    @media = Medium.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media }
    end
  end

  # GET /media/1
  # GET /media/1.json
  def show
    medium = Medium.find_by_url(params[:id])
    redirect_to medium_audios_path(medium), status: 301
  end

  # GET /media/new
  # GET /media/new.json
  def new
    authorize! :create, @media
    @medium = Medium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/1/edit
  def edit
    authorize! :create, @media
    @medium = Medium.find_by_url(params[:id])
  end

  # POST /media
  # POST /media.json
  def create
    authorize! :create, @media
    @medium = current_user.media.build(params[:medium])

    respond_to do |format|
      if @medium.save
        format.html { redirect_to @medium, notice: 'Medium was successfully created.' }
        format.json { render json: @medium, status: :created, location: @medium }
      else
        format.html { render action: "new" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media/1
  # PUT /media/1.json
  def update
    authorize! :create, @media
    @medium = Medium.find_by_url(params[:id])

    respond_to do |format|
      if @medium.update_attributes(params[:medium])
        format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    authorize! :create, @media
    @medium = Medium.find_by_url(params[:id])
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to media_url }
      format.json { head :no_content }
    end
  end
end
