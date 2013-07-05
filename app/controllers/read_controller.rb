class ReadController < ApplicationController
  
  def show
    #:book_id/:canto_id/:section_id
    sectionrunningno=params[:section_id]
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    @canto = Canto.find_by_no_and_book_id(cantoid,bookid)
    @sections = @canto.sections.where(:runningno=>sectionrunningno).order("no")
    @stanzas = Stanza.by_section(@sections.first.id).order("no")

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
    section=Section.find_by_no(query[0])
    sectionrunningno = section.runningno
    canto=Section.find_by_no(section.id).canto
    cantoid = canto.no
    bookid = Book.find(canto.book_id).id
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s+'#'+query[1]
  end
end
