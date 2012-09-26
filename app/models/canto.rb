class Canto < ActiveRecord::Base
  attr_accessible :cantono, :description, :title
  has_many :stanzas
  has_many :lines , :through => :stanzas

  validates :cantono, :title, :uniqueness => true
  validates :cantono, :title, :presence=> true
  
end
