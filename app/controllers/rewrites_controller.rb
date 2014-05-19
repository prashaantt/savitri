class RewritesController < ApplicationController
  # GET /rewrites
  # GET /rewrites.json
  def index
    @rewrites = Rewrite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rewrites }
    end
  end

  # GET /rewrites/1
  # GET /rewrites/1.json
  def show
    @rewrite = Rewrite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rewrite }
    end
  end

  # GET /rewrites/new
  # GET /rewrites/new.json
  def new
    @rewrite = Rewrite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rewrite }
    end
  end

  # GET /rewrites/1/edit
  def edit
    @rewrite = Rewrite.find(params[:id])
  end

  # POST /rewrites
  # POST /rewrites.json
  def create
    @rewrite = Rewrite.new(params[:rewrite])

    respond_to do |format|
      if @rewrite.save
        format.html { redirect_to @rewrite, notice: 'Rewrite was successfully created.' }
        format.json { render json: @rewrite, status: :created, location: @rewrite }
      else
        format.html { render action: "new" }
        format.json { render json: @rewrite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rewrites/1
  # PUT /rewrites/1.json
  def update
    @rewrite = Rewrite.find(params[:id])

    respond_to do |format|
      if @rewrite.update_attributes(params[:rewrite])
        format.html { redirect_to @rewrite, notice: 'Rewrite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rewrite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewrites/1
  # DELETE /rewrites/1.json
  def destroy
    @rewrite = Rewrite.find(params[:id])
    @rewrite.destroy

    respond_to do |format|
      format.html { redirect_to rewrites_url }
      format.json { head :no_content }
    end
  end
end
