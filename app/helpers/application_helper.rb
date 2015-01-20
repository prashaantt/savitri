module ApplicationHelper

	def title(page_title)
		content_for(:title) {" - " +page_title}
	end

  def meta_desc(metadesc)
    content_for(:meta_desc) { "Sri Aurobindo's Savitri " + metadesc }
  end

  def meta_keywords(keywords)
    content_for(:meta_keywords) { 'Sri Aurobindo, Savitri, ' + keywords}
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

  def is_active_section(params,no,cantono)
  	ac=""
  	if params[:section_id].eql? no
      if params[:canto_id].eql? cantono
  		  ac="active"
      else
        ac="nonactive"
      end
  	else
  		ac="nonactive"
  	end
  	ac
  end

  def share_url(stanza)
    section = stanza.cached_section
    edition = params[:edition] || stanza.edition_year
    "/read/"+section.cached_number.to_s+"."+stanza.cached_runningno.to_s+"?edition=#{edition}"
  end

  def cancel_page (type)
    if session[:last_page]
      link_to "Cancel", session[:last_page], :class => 'btn'
    else
      if "Post" == type
        link_to "Cancel", blog_posts_path, :class => 'btn'
      elsif "Page" == type
        link_to "Cancel", pages_path, :class => 'btn'
      elsif "Task" == type
        link_to "Cancel", tasks_path, :class => 'btn'
      end
    end
  end

  def toggle_class(post)
    if post.featured?
      'icon-star pull-right'
    else
      'icon-star-empty pull-right'
    end
  end

  def background_color
    if params[:controller] == 'savitri'
      'brown'
    else
      'light-yellow'
    end
  end
end
