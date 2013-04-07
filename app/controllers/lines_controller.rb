class LinesController < ApplicationController
  # GET /lines
  # GET /lines.json
  #load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:range]
  
  def index
    @lines = Line.order(:no).page(params[:lines]).per(10)
    authorize! :index, @lines
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
    @line = Line.find_by_no(params[:id])
    authorize! :index, @line
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/range/1..20
  # GET /lines/range/1..20.json
  def range
    #@lines = Line.where(:no=> params[:id])
    line_range = params[:id].split("-")
    @lines = Line.where(:no=>line_range[0]..line_range[1])
    line_op = Hash.new
    @lines.each do |l|
      #@lines[l.stanza.no] = l.stanza.section.to_s + "." + l.stanza.runningno.to_s
      #Section.find(@sentence.section).no.to_s + "." + @sentence.runningno.to_s
    end
    respond_to do |format|
      format.html #range.html.erb
      #format.json { render json: @lines }
      format.json {render :json => @lines.to_json(:only =>[:line, :stanza_id],:methods=>[:section,:runningno,:share_url])}
      #format.json {render :json => {:lines => @lines, :marker => line_op }}
    end
  end

  # GET /lines/new
  # GET /lines/new.json
  def new
    @line = Line.new
    authorize! :new, @line

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/1/edit
  def edit
    @line = Line.find_by_no(params[:id])
    authorize! :edit, @line
  end

  # POST /lines
  # POST /lines.json
  def create
    #--edit
    if params[:line][:no].blank?
      num=0
    else
      nu = params[:line][:no].to_f
      num =  nu -1
    end
    logger.info '------------------------create---------------------'
    stanznu = Stanza.last.no + 1
    section_no = Section.last.no + 1
    logger.info '----create new section---'
    runningnum = 1
    @section = Section.new(:no=>section_no, :canto_id =>Section.last.canto_id)
    @section.save
    @stan = Stanza.new(:no=>stanznu, :section_id=>section_no, :runningno=>runningnum)
    runningnum=runningnum+1
    @stan.save
    @line_arr = params[:line][:line].to_s.split("\r\n")
    
    @line_arr.each_with_index do |l, index|
      logger.info l
      logger.info '----check full-stop---'
      l=l.strip
      if l.match(/[\.\?\!]$/)
        num=num+1
        @line = Line.new(:no=>num,:line=>l,:stanza_id=>stanznu)
        @line.save
        logger.info "--created new stanza--"
        if(index!=@line_arr.length-1)
          stanznu = stanznu + 1
          @stan2=Stanza.new(:no=>stanznu, :section_id=>section_no,:runningno=>runningnum)
          runningnum=runningnum+1
          @stan2.save
        end
      else
        num=num+1
        @line = Line.new(:no=>num,:line=>l,:stanza_id=>stanznu)
        @line.save
      end
    end
    logger.info '------------------------endcreate---------------------'
    #--editEnd
    #@line = Line.new(params[:line])
    authorize! :create, @line
    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, notice: 'Line was successfully created.' }
        format.js
        format.json { render json: @line, status: :created, location: @line }
      else
        format.html { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lines/1
  # PUT /lines/1.json
  def update
    @line = Line.find_by_no(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:line])
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line = Line.find_by_no(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to lines_url }
      format.json { head :no_content }
    end
  end
end