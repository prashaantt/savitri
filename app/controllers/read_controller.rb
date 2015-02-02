class ReadController < ApplicationController

  def show
    #:book_id/:canto_id/:section_id
    sectionrunningno=params[:section_id]
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    @edition = find_edition_by_year params
    @remaining_editions = Edition.where('id != ?', @edition.id)
    @book = @edition.books.where(no:bookid).try(&:first)
    @canto = Canto.cached_find_by_no_and_bookid(cantoid, @book.id)
    if @canto.nil?
      location = Rewrite.find_by_source(request.fullpath)
      if location
        redirect_to location.destination, :status => location.code
        return
      else
        not_found
      end
    end
    @sections = @canto.sections_cache_with_runningno(sectionrunningno)
    #@stanzas = Stanza.cached_by_section(@sections.first.id)
    @stanzas = @sections.first.cached_stanzas
    respond_to do |format|
      format.html # index.html.erb
      format.js
      @stanzasj = [@sections.first.no] + [@sections.first.cached_stanzas]
      format.json { render json: @stanzasj, methods: [:cached_lines] }
    end
  end

  def find_edition_by_year params
    params[:edition].present? ? Edition.find_by_year(params[:edition]) : Edition.first
  end

  def bookcantoshow
    sectionrunningno=1
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s
  end

  def specific
    edition = find_edition_by_year params
    query = params[:book_id].split('.')
    section = edition.sections.cached_find_by_no(query[0],edition.year)
    sectionrunningno = section.cached_runningno
    canto=section.canto
    cantoid = canto.cached_number
    bookid = Book.cached_find(canto.book_id).no
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s+'?edition='+edition.year.to_s+'#'+query[1]
  end

  def index
    redirect_to '/read/1/1/1'
  end
end
