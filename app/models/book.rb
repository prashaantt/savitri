class Book < ActiveRecord::Base
  attr_accessible :description, :name, :no
  has_many :cantos
  has_many :stanzas , :through => :cantos
  has_many :lines, :through => :stanzas

  validates :no, :name, :uniqueness => true
  validates :no, :name, :presence=> true
end
