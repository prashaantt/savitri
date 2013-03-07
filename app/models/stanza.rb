class Stanza < ActiveRecord::Base
  attr_accessible :no, :section_id
  has_many :lines, :order => 'no'
  belongs_to :section

  validates :no , :uniqueness => true

  def to_param
  	no
  end

  def to_s
    "Sentence"
  end

  searchable do 
    text :no
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
    self.class.to_s + "s"
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

end
