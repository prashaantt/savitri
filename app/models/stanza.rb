class Stanza < ActiveRecord::Base
  attr_accessible :no, :section_id, :runningno
  has_many :lines, :order => 'no'
  belongs_to :section
  scope :by_section, lambda { |q| where(:section_id=>q ) }

  validates :no , :uniqueness => true

  def to_param
  	no
  end

  # def self.to_s
  #   "Sentence"
  # end

  searchable do 
    text :share_url
    text :lines do |l|
      l.lines.map {|l| l.line}
    end
#  --facets below--    
    integer :id
    string :category
    string :section
    string :canto
    string :sbook
    string :length
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
