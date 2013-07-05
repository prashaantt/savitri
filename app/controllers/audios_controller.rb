class AudiosController < ApplicationController
  # GET /audios
  # GET /audios.json
  def index
    @medium = Medium.find_by_url(params[:medium_id])
    
    if params[:tag]
      @audios = Audio.tagged_with(params[:tag]).where(:medium_id => @medium.id).page(params[:page]).per(5)
    else
      @audios = @medium.audios.order("created_at DESC").page(params[:page]).per(5)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.rss
      format.json { render json: @audios }
    end
  end

  # GET /audios/1
  # GET /audios/1.json
  def show
    @medium = Medium.find_by_url(params[:medium_id])
    @audio = Audio.find_by_medium_id_and_url(@medium.id, params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audio }
    end
  end

  # GET /audios/new
  # GET /audios/new.json
  def new
    authorize! :create, @media
    @audio = Audio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audio }
    end
  end

  # GET /audios/1/edit
  def edit
    authorize! :create, @media
    @medium = Medium.find_by_url(params[:medium_id])
    @audio = Audio.find_by_medium_id_and_url(@medium.id, params[:id])
  end

  # POST /audios
  # POST /audios.json
  def create
    authorize! :create, @media
    @audio = Audio.new(params[:audio])

    respond_to do |format|
      if @audio.save
        format.html { redirect_to medium_audio_path(@audio.medium, @audio), notice: 'Audio was successfully created.' }
        format.json { render json: @audio, status: :created, location: @audio }
      else
        format.html { render action: "new" }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /audios/1
  # PUT /audios/1.json
  def update
    authorize! :create, @media
    @audio = Audio.find_by_medium_id_and_url(params[:audio][:medium_id], params[:id])

    respond_to do |format|
      if @audio.update_attributes(params[:audio])
        format.html { redirect_to medium_audio_path(@audio.medium, @audio), notice: 'Audio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.json
  def destroy
    authorize! :create, @media
    @medium = Medium.find_by_url(params[:medium_id])
    @audio = Audio.find_by_medium_id_and_url(@medium.id, params[:id])
    @audio.destroy

    respond_to do |format|
      format.html { redirect_to medium_audios_path }
      format.json { head :no_content }
    end
  end
end
