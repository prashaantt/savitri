class Stanza < ActiveRecord::Base
  attr_accessible :stanzno, :canto_id
  has_many :lines, :order => 'no'
  belongs_to :canto

  validates :stanzno , :uniqueness => true


  def to_param
  	stanzno
  end

  searchable do 
    text :stanzno
    text :lines do |l|
      l.lines.map {|l| l.line}
    end
    integer :id
    string :length
    string :category
    string :sbook
  end

  def category
    "sentence"
  end

  def sbook
    Canto.find(self.canto_id).book_id.to_s
  end

  def sentence
    Stanza.find(self.stanzno).lines
  end

  def length
     Stanza.find(self.stanzno).lines.count.to_s
  end

end
