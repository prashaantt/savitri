class Stanza < ActiveRecord::Base
  attr_accessible :stanzno, :canto_id
  has_many :lines, :order => 'no'
  belongs_to :canto

  validates :stanzno , :uniqueness => true


  def to_param
  	stanzno
  end

  # searchable do 
  #   string :length
  # end


  def length
     Stanza.find(self.id).lines.count.to_s
  end

end
