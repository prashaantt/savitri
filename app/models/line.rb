class Line < ActiveRecord::Base
  attr_accessible :line, :no, :stanza_id
  belongs_to :stanza

  validates :no, :uniqueness => true, numericality: { only_integer: true }
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
     time :published_at do
      Time.zone.now
     end
   end

  def category
    self.class.name + "s"
  end

  def self.cached_all
    Rails.cache.fetch([name,"lineall"]) { order('no').to_a }
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

  def cached_line
    Rails.cache.fetch([self, "line"]) { line }
  end

  def cached_number
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
    Section.find_by_no(section).canto.book.no
  end

  def lbook
    Section.find_by_no(section).canto.book.no
  end

  def length
    Stanza.find(self.stanza_id).lines.count
  end
end
