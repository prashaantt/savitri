class Canto < ActiveRecord::Base
  attr_accessible :cantono, :description, :title, :book_id
  has_many :stanzas
  has_many :lines , :through => :stanzas
  belongs_to :book
  
  validates :cantono, :title, :uniqueness => true
  validates :cantono, :title, :presence=> true
  
  def to_param
  	cantono
  end
  
  searchable do 
    text :line
    text :cantono
  end

  def line
  	self.lines
  end

end
