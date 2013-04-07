module ApplicationHelper
	def is_active(controller)
			(params[:controller] == controller) ? "active" : nil 
  	end

  	def link_to_add_fields(name,f,type)
  		new_object = f.object.send "build_#{type}"
  		id = "new_#{type}"
  		fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
  			render(type.to_s + "_fields" , f: builder)
  		end
  		link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n","")})
  	end

    def page_no(sentence)
      stanza = Stanza.find_by_no(sentence)
      section = stanza.section
      canto = stanza.canto
      runningno = stanza.runningno
      firstsectionofthiscanto = Canto.find(canto).sections.first.no
      if (section==firstsectionofthiscanto)
       if runningno%4 == 0
        page_no = (runningno)/4
       else
        page_no = (runningno)/4 + 1
      end
    else
      totalsections = Canto.find(stanza.canto).sections.count
      firstsection =Canto.find(stanza.canto).sections.first.no
      adder =0
      i=firstsection
      puts "firstsection" + firstsection.to_s + " --totalsections" + totalsections.to_s
      while  i< (totalsections + firstsection-1)
        adder = adder + Section.find(i).stanzas.last.runningno
        i=i+1
      end
      puts "ADDER ==" + adder.to_s
      if adder%4 == 0 
        adderpage = (adder)/4
      else
        adderpage = (adder/4)+1
      end
      puts "runningno --------" + runningno.to_s
      puts "adderpage --------" + adderpage.to_s
      if (runningno+adder)%4 == 0
        page_no =(runningno+adder)/4
       else
        page_no =(runningno+adder)/4 + 1
      end
    
      page_no
    end
end
end
