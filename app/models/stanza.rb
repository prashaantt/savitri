class Stanza < ActiveRecord::Base
  attr_accessible :stanzno, :canto_id
  has_many :lines, :order => 'no'
  belongs_to :canto

  validates :stanzno , :uniqueness => true


  def to_param
  	stanzno
  end
  
  UNRANSACKABLE_ATTRIBUTES = ["id", "created_at", "updated_at", "canto_id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end


end
