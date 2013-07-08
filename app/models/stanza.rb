class Stanza < ActiveRecord::Base
  attr_accessible :no, :section_id, :runningno
  has_many :lines, :order => 'no'
  belongs_to :section
  #scope :_section, lambda { |q| where(:section_id=>q ) }

  validates :no , :uniqueness => true

  def to_param
  	no
  end

  # def self.to_s
  #   "Sentence"
  # end

  searchable do 
    text :share_url, :stored => true
    text :lines, :stored => true do 
      lines.map {|l| l.line}
    end
#  --facets below--    
    integer :id
    string :category
    string :section
    string :canto
    string :sbook
    string :length
  end

  def cached_lines
    Rails.cache.fetch([self,"lines"]) { lines }
  end

  def self.cached_all
    Rails.cache.fetch([name,"stanzaall"]) { order('no').to_a }
  end


  def self.cached_by_section(q)
    Rails.cache.fetch([name, "cached_by_section"+q.to_s]) { self.where(:section_id=>q ).all }
  end

  def cached_runningno
    Rails.cache.fetch([self, "runningno"]) { runningno }
  end
  
  def cached_number
    Rails.cache.fetch([self, "no"]) { no }
  end

  def self.cached_find_by_no(no)
    Rails.cache.fetch([name, no]) { find_by_no(no) }
  end

  def cached_section
    Rails.cache.fetch([self, "section"]) { section }
  end


  def category
    "Sentences"
  end

  def section
    Section.find(self.section_id).no
  end

  def canto
    Canto.find(Section.find_by_no(section).canto_id).no
  end

  def sbook
    Book.find(Canto.find_by_no(canto).book_id).no
  end

  def length
    Stanza.find(self.no).lines.count.to_s
  end

  # def sentence
  #   Stanza.find(self.no).lines
  # end

  def share_url
    section.to_s + "." + runningno.to_s
  end

  def self.random
    Stanza.offset(rand(Stanza.count)).first
  end

end
