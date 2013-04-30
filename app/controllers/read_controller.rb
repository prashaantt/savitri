class ReadController < ApplicationController
  
  def show
    #:book_id/:canto_id/:section_id
    sectionrunningno=params[:section_id]
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    @canto = Canto.find_by_id_and_book_id(cantoid,bookid)
    @sections = @canto.sections.where(:runningno=>sectionrunningno)
    @stanzas = Stanza.by_section(@sections.first.id).order("no")
    expires_in(7.days, public: true)
    if stale?(:last_modified => @canto.updated_at.utc, :etag => @canto)
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @stanzas }
    end
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
    section=Section.find_by_no(query[0])
    sectionrunningno = section.runningno
    canto=Section.find_by_no(section.id).canto
    cantoid = canto.id
    bookid = Book.find(canto.book_id).id
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s+'#'+query[1]
  end
end
