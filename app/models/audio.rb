class Audio < ActiveRecord::Base
  attr_accessible :audio_url, :author, :block, :closedcaptioned, :explicit, :file_size, :order, :seconds, :summary, :title, :url,
  :medium_id
  belongs_to :medium

  validates :title, :presence => true, :length => { :minimum => 3 }
  validates :summary, :presence => true, :length => { :minimum => 10 }
  validates :audio_url, :presence => true
  validates :seconds, :presence => true
  validates :file_size, :presence => true

  def to_param
    "#{url}"
  end 
end
