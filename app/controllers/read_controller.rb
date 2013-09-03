class ReadController < ApplicationController
  
  def show
    #:book_id/:canto_id/:section_id
    sectionrunningno=params[:section_id]
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    @canto = Canto.cached_find_by_no_and_bookid(cantoid, bookid) || not_found
    @sections = @canto.sections_cache_with_runningno(sectionrunningno)
    #@stanzas = Stanza.cached_by_section(@sections.first.id)
    @stanzas = @sections.first.cached_stanzas
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @stanzas }
    end
  end

  def bookcantoshow
    sectionrunningno=1
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s
  end

  def specific
    query = params[:book_id].split('.')
    section=Section.cached_find_by_no(query[0])
    sectionrunningno = section.cached_runningno
    canto=Section.cached_find_by_no(section.no).cached_canto
    cantoid = canto.cached_number
    bookid = Book.cached_find(canto.book_id).no
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s+'#'+query[1]
  end
end
