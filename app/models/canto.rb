class Canto < ActiveRecord::Base
  attr_accessible :no, :description, :title, :book_id
  has_many :sections
  has_many :stanzas , :through => :sections
  belongs_to :book
  
  validates :no, :title, :uniqueness => true
  validates :no, :title, :presence=> true
  
  def to_param
  	no
  end
  
  # searchable do 
  #   text :line
  #   text :no
  # end

  # def line
  # 	self.lines
  # end

end
