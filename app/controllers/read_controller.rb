class ReadController < ApplicationController
  def index
  	#@cantos = Canto.includes("stanzas").includes("lines").order("cantono").page(params[:cantos]).per(1)
  	#@lines = Line.order("no").page(params[:cantos]).per(5)
  	@stanzas = Stanza.includes("lines").order("no").page(params[:pages]).per(4)

  	respond_to do |format|
      format.html # index.html.erb
      format.js 
      format.json { render json: @stanzas }
    end
  end

  def show
    #:book_id/:canto_id/:section_id
    puts params.inspect
    totalpages = params[:pages] || 1
    puts params.inspect
    sectionrunningno=params[:section_id]
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    @canto = Canto.find_by_id_and_book_id(cantoid,bookid)
    @sections = @canto.sections.where(:runningno=>sectionrunningno)
    @stanzas = Stanza.by_section(@sections.first.id).order("no").page(totalpages).per(4)
    #@stanzas = Stanza.find(:conditions => { :canto_id => @canto.id}) 
#    @stanzas = Stanza.includes("lines").order("stanzno").page(params[:stanzas]).per(4)
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @stanzas }
    end
  end

  def bookcantoshow
    puts params.inspect
    sectionrunningno=1
    cantoid=params[:canto_id]
    bookid=params[:book_id]
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s
  end

  def specific
    totalpages=1
    query = params[:book_id].split('.')
    section=Section.find_by_no(query[0])
    sectionrunningno = section.runningno
    canto=Section.find_by_no(section.id).canto
    cantoid = canto.id
    bookid = Book.find(canto.book_id).id
    if query[1].to_i%4 == 0
      totalpages = (query[1].to_i)/4
    else
      totalpages = (query[1].to_i)/4 + 1
    end
    redirect_to '/read/'+bookid.to_s+'/'+cantoid.to_s+'/'+sectionrunningno.to_s+'?pages='+totalpages.to_s+'#'+params[:book_id]
  end
end
