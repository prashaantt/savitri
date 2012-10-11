class CantosController < ApplicationController
  # GET /cantos
  # GET /cantos.json
  def index
    @cantos = Canto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cantos }
    end
  end

  # GET /cantos/1
  # GET /cantos/1.json
  def show
    @canto = Canto.find_by_cantono(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @canto }
    end
  end

  # GET /cantos/new
  # GET /cantos/new.json
  def new
    @canto = Canto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @canto }
    end
  end

  # GET /cantos/1/edit
  def edit
    @canto = Canto.find_by_cantono(params[:id])
  end

  # POST /cantos
  # POST /cantos.json
  def create
    @canto = Canto.new(params[:canto])

    respond_to do |format|
      if @canto.save
        format.html { redirect_to @canto, notice: 'Canto was successfully created.' }
        format.json { render json: @canto, status: :created, location: @canto }
      else
        format.html { render action: "new" }
        format.json { render json: @canto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cantos/1
  # PUT /cantos/1.json
  def update
    @canto = Canto.find_by_cantono(params[:id])

    respond_to do |format|
      if @canto.update_attributes(params[:canto])
        format.html { redirect_to @canto, notice: 'Canto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @canto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cantos/1
  # DELETE /cantos/1.json
  def destroy
    @canto = Canto.find_by_cantono(params[:id])
    @canto.destroy

    respond_to do |format|
      format.html { redirect_to cantos_url }
      format.json { head :no_content }
    end
  end
end
