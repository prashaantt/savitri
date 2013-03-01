class Line < ActiveRecord::Base
  attr_accessible :line, :no, :stanza_id
  belongs_to :stanza

  validates :no, :uniqueness => true
  validates :line, :no, :stanza_id, :presence => true

  accepts_nested_attributes_for :stanza, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }


  def to_param
  	no
  end


  searchable do 
    text :line
    text :no
    integer :id
    string :canto
    string :length
  end

  def canto
    Stanza.find(Line.find(self.id).stanza_id).canto_id.to_s
  end

  def length
      Stanza.find(self.stanza_id).lines.count
  end
  
  #UNRANSACKABLE_ATTRIBUTES = ["id", "created_at", "updated_at", "stanza_id"]

  #def self.ransackable_attributes auth_object = nil
  #  (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  #end

end
