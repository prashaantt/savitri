class Section < ActiveRecord::Base
  attr_accessible :name, :no, :references, :canto_id
  has_many :stanzas
  belongs_to :canto
end
