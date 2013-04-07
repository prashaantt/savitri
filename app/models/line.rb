class Line < ActiveRecord::Base
  attr_accessible :line, :no, :stanza_id
  belongs_to :stanza

  validates :no, :uniqueness => true
  validates :line, :no, :stanza_id, :presence => true

  accepts_nested_attributes_for :stanza, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }


  def to_param
  	no
  end

   searchable do 
     text :line
     text :no
     integer :id
#  --facets below--
     string :section
     string :canto
     string :lbook
     string :length
     string :category
   end

  def category
    self.class.name + "s"
  end

  def runningno
    stanza.runningno
  end

  def share_url
    #$("#poem-text").append("||"+te.section+"."+te.runningno+"||\r\n")
    text = "/read/"+canto.to_s+"?pages="+page_no(stanza.no).to_s+"#"+section.to_s+"."+runningno.to_s
    #link_to read_path(stanza)
  end

  def section
    Section.find(Stanza.find(self.stanza_id).section_id).no
  end

  def canto
    Canto.find(Section.find_by_no(section).canto_id).no
  end

  def book
    Book.find(Canto.find_by_no(canto).book_id).no
  end

  def lbook
    book
  end

  def length
    Stanza.find(self.stanza_id).lines.count
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
