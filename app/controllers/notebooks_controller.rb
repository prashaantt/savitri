class NotebooksController < ApplicationController

  before_filter :store_location
  before_filter :authenticate_user!

  # GET /notebooks
  # GET /notebooks.json

  def index
    @notebooks = Notebook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notebooks }
    end
  end


  #{"annotation":"As","created_at":"2013-01-09T06:40:51Z",
  # "end":"/div/p[2]","endoffset":38,"externalurl":null,
  # "id":1,"line":null,"line_id":null,"quote":"Gods awake",
  # "start":"/div/p[2]","startoffset":27,"updated_at":"2013-01-09T06:40:51Z",
  # "uri":"http://localhost:3000/read","user_id":14}
  # ------------------------------------------------------------------------
  # {"text"=>"Testing", "ranges"=>[{"start"=>"/div/p[7]",
  # "startOffset"=>2, "end"=>"/div/p[7]", "endOffset"=>33}],
  # "quote"=>"n her unlit temple of eternity,",
  # "uri"=>"http://this/document/only", "prefix"=>"", "notebook"=>{}}

  def search
    @notes = Notebook.where(:user_id=>current_user, :uri=>params[:uri]).limit(params[:limit])
    @noti = change_format @notes
    @notebooks = {"rows" => @noti }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notebooks }
    end
  end
  # GET /notebooks/1
  # GET /notebooks/1.json
  def show
    @notebook = Notebook.find(params[:id]) || not_found

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notebook }
    end
  end

  # GET /notebooks/new
  # GET /notebooks/new.json
  def new
    @notebook = Notebook.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notebook }
    end
  end

  # GET /notebooks/1/edit
  def edit
    @notebook = Notebook.find(params[:id]) || not_found
  end

  # POST /notebooks
  # POST /notebooks.json
  # {"text"=>"Testing", "ranges"=>[{"start"=>"/div/p[7]",
  # "startOffset"=>2, "end"=>"/div/p[7]", "endOffset"=>33}],
  # "quote"=>"n her unlit temple of eternity,",
  # "uri"=>"http://this/document/only", "prefix"=>"", "notebook"=>{}}
  def create
    @notebook = Notebook.new(params[:notebook])
    #notebook.line - style params
    #logger.debug "#{params[:ranges].first}"
    
    @notebook.annotation = params[:text]
    @notebook.user_id = current_user.id
    @notebook.quote = params[:quote]
    @notebook.uri = params[:uri]
    @notebook.start = params[:ranges].first[:start]
    @notebook.startoffset = params[:ranges].first[:startOffset]
    @notebook.end = params[:ranges].first[:end]
    @notebook.endoffset = params[:ranges].first[:endOffset]

    respond_to do |format|
      if @notebook.save
        format.html { redirect_to @notebook, notice: 'Notebook was successfully created.' }
        format.json { render json: @notebook, status: :created, location: @notebook }
      else
        format.html { render action: "new" }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notebooks/1
  # PUT /notebooks/1.json
  def update
    @notebook = Notebook.find(params[:id])
    
    respond_to do |format|
      if @notebook.update_attributes(:annotation=>params[:text])
        format.html { redirect_to @notebook, notice: 'Notebook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notebooks/1
  # DELETE /notebooks/1.json
  def destroy
    @notebook = Notebook.find(params[:id])
    @notebook.destroy
    respond_to do |format|
      format.html { redirect_to notebooks_url }
      format.json { head :no_content }
    end
  end

  private
  def change_format notes
    @noti = Array.new
    @rows = Array.new
    @notes.each do |note|
      @n = Note.new
      @n.text = note.annotation
      @n.id = note.id
      @range = {"start"=>note.start, "startOffset"=>note.startoffset, "end" => note.end, "endOffset"=> note.endoffset}
      @n.ranges = Array.new
      @n.ranges.push(@range)
      @n.quote = note.quote
      @n.uri = note.uri
      @noti << @n
    end
    @noti
  end
end
