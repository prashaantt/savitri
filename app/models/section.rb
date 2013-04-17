class Section < ActiveRecord::Base
  attr_accessible :name, :no, :references, :canto_id, :runningno, :id
  has_many :stanzas
  has_many :lines, :through => :stanzas
  belongs_to :canto
end
