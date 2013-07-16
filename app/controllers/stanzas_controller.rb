class StanzasController < ApplicationController
  # GET /stanzas
  # GET /stanzas.json
  before_filter :authenticate_user!, :except => [:range]
  
  def index
    @stanzas = Stanza.order(:no)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stanzas }
    end
  end

  # GET /stanzas/range/1..20
  # GET /stanzas/range/1..20.json
  def range
    #@lines = Line.where(:no=> params[:id])
    line_range = params[:id].split("-")
    fstan = Stanza.find_by_runningno_and_section_id(line_range[1],line_range[0])
    sstan = Stanza.find_by_runningno_and_section_id(line_range[3],line_range[2])
    @stanzas = Stanza.where(:no=>fstan.no..sstan.no)
    lines = Array.new
    #@stanzas.each {|s| lines << s.cached_lines }
    @stanzas.each {|s| lines << s.lines }
    respond_to do |format|
      format.html #range.html.erb
      format.json {render :json => lines.to_json(:only =>[:line],:methods=>[:section,:runningno,:share_url,:no])}
    end
  end

  # GET /stanzas/1
  # GET /stanzas/1.json
  def show
    #@stanza = Stanza.find(params[:id])
    #@stanza = Stanza.where(:stanzno=>params[:id])
    @stanza = Stanza.find_by_no(params[:id])
    logger.info @stanza

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stanza }
    end
  end

  # GET /stanzas/new
  # GET /stanzas/new.json
  def new
    @stanza = Stanza.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stanza }
    end
  end

  # GET /stanzas/1/edit
  def edit
    @stanza = Stanza.find_by_no(params[:id])
  end

  # POST /stanzas
  # POST /stanzas.json
  def create
    @stanza = Stanza.new(params[:stanza])

    respond_to do |format|
      if @stanza.save
        format.html { redirect_to @stanza, notice: 'Stanza was successfully created.' }
        format.json { render json: @stanza, status: :created, location: @stanza }
      else
        format.html { render action: "new" }
        format.json { render json: @stanza.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stanzas/1
  # PUT /stanzas/1.json
  def update
    @stanza = Stanza.find_by_no(params[:id])

    respond_to do |format|
      if @stanza.update_attributes(params[:stanza])
        format.html { redirect_to @stanza, notice: 'Stanza was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stanza.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stanzas/1
  # DELETE /stanzas/1.json
  def destroy
    @stanza = Stanza.find_by_no(params[:id])
    @stanza.destroy

    respond_to do |format|
      format.html { redirect_to stanzas_url }
      format.json { head :no_content }
    end
  end
end
