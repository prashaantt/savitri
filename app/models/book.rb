class Book < ActiveRecord::Base
  attr_accessible :description, :name, :no
  has_many :cantos
  has_many :stanzas , :through => :cantos
  has_many :lines, :through => :stanzas

  validates :no, :name, :uniqueness => true
  validates :no, :name, :presence=> true

  def to_param
  	no
  end

  searchable do 
    text :name
    text :no
    integer :id
    string :category
    string :book
    string :canto
    string :section
  end

  def book
  	self.no
  end

  def canto
    self.cantos.no
  end

  def section
    self.cantos.map {|a| a.no}
  end

  def category
    self.class.name + "s"
  end

end
