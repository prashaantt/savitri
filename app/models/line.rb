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

  def canto_id
  end

   searchable do 
     text :line, :stored => true
     #text :no
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

  def self.cached_wherestan(q)
    Rails.cache.fetch([name, "stanza"+q.to_s]) { where(:stanza_id=>q) }
  end

  def self.cached_wheres(q)
    where(:stanza_id=>q)
  end
  def self.cached_all
    #Rails.cache.fetch(["lineall"]) { find_by_stanza_id(2) }
    Rails.cache.fetch(["lineall2"]) { where(:stanza_id=>2) }
  end
  def self.cached_all2
    Rails.cache.fetch(["lineall2"]) { where(:stanza_id=>2).all }
  end
  def cached_line
    Rails.cache.fetch([self, "line"]) { line }
  end

  def cached_no
    Rails.cache.fetch([self, "no"]) { no }
  end

  def share_url
    "/read/"+section.to_s+"."+stanza.runningno.to_s
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
end
