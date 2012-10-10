class Canto < ActiveRecord::Base
  attr_accessible :cantono, :description, :title, :book_id
  has_many :stanzas
  has_many :lines , :through => :stanzas
  belongs_to :books
  
  validates :cantono, :title, :uniqueness => true
  validates :cantono, :title, :presence=> true
  
end
