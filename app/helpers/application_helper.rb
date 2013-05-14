module ApplicationHelper

	def title(page_title)
		content_for(:title) {" - " +page_title}
	end

	def is_active(controller)
    (params[:controller] == controller) ? "active" : "notactive" 
 	end

  def is_collapsed(params, bid)
    clas=Array.new
    if params[:book_id].eql? bid
      clas[0]="collapsed"
      clas[1]="collapsed"
    else
      clas[0]=""
      clas[1]=""
    end
    clas
  end
 	def is_active_link(params,bid,cid)
 		claz=""
 		if params[:book_id].eql? bid
 			if params[:canto_id].eql? cid
 				claz="activeaccordion"
 			else
 				claz="inactiveaccordion"
 			end
 		else
 			claz="inactiveaccordion"
 		end
 		claz
 	end

  def share_url(sentence_number)
    stanza = Stanza.find_by_no(sentence_number)
    section = Section.find(stanza.section)
    section_running_no = section.runningno
    "/read/"+section.no.to_s+"."+stanza.runningno.to_s
  end
end
