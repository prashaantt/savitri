class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  before_filter :store_location, :last_page
  before_filter :authenticate_user!, except: [:show, :parents]

  def index
    @pages = Page.cached_all
    authorize! :create, @pages
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if params[:paths].nil?
      @page = Page.find_by_permalink(params[:id])
      if !@page
        location = Rewrite.find_by_source(request.fullpath)
        if location
          redirect_to location.destination, :status => location.code
          return
        else
          redirect_to '/search/?q='+params[:q].split('/').last.gsub('-','+')
          return
        end
      end
    else
      @page = Page.find_by_permalink!(params[:paths]) || not_found
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id]) || not_found
    @page.url = @page.permalink.split('/').last
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    if params[:page][:category] == 'Non-Menu'
      params[:page][:priority] = nil
    else
      params[:page][:parent] = nil
    end

    respond_to do |format|
      if @page.save
        format.html { redirect_to page_path(@page), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    if params[:paths].nil?
      @page = Page.find(params[:page][:id])
    else
      @page = Page.find_by_permalink!(params[:paths])
    end

    if params[:page][:category] == 'Non-Menu'
      params[:page][:priority] = nil
    else
      params[:page][:parent] = nil
    end

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to page_path(@page), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    child = Page.find_by_parent(params[:id])
    if child.nil?
      @page.destroy
      respond_to do |format|
        format.html { redirect_to pages_path }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        if params[:show].nil?
          format.html { redirect_to pages_path, notice: 'This page is a parent of one or more pages and cannot be deleted before all its subpages are removed.' }
        else
          format.html { redirect_to page_path(@page.permalink), notice: 'This page is a parent of one or more pages and cannot be deleted before all its subpages are removed.' }
        end
        format.json { head :no_content }
      end
    end
  end
end
