class LinesController < ApplicationController
  # GET /lines
  # GET /lines.json
  load_and_authorize_resource
  
  def index
    @lines = Line.order(:no).page(params[:lines]).per(10)

    text = "this is a text containing no new-line
             this contains a new line nism"
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
    @line = Line.find_by_no(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/new
  # GET /lines/new.json
  def new
    @line = Line.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/1/edit
  def edit
    @line = Line.find_by_no(params[:id])
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
    params[:line][:line].to_s.split("\r\n").each do |l|
      logger.info l
      num=num+1
      @line = Line.new(:no=>num,:line=>l,:stanza_id=>params[:line][:stanza_id])
      @line.save
    end
    logger.info '------------------------endcreate---------------------'
    #--editEnd
    #@line = Line.new(params[:line])
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
