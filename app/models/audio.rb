class Audio < ActiveRecord::Base
  attr_accessible :audio_url, :author, :block, :closedcaptioned, :explicit, :file_size, :order, :seconds, :summary, :title, :url, :medium_id, :tag_list
  acts_as_taggable
  acts_as_url :title
  belongs_to :medium
  has_many :tags

  validates :title, :presence => true, :length => { :minimum => 3 }
  validates :summary, :presence => true, :length => { :minimum => 10 }
  validates :audio_url, :presence => true
  validates :seconds, :presence => true
  validates :file_size, :presence => true

  def to_param
    "#{url}"
  end

  def duration
    time = Time.at(seconds).utc
    duration = Hash.new
    duration["total"] = time.strftime("%k").to_s + ":" + time.strftime("%M").to_s + ":" + time.strftime("%S").to_s
    duration["hours"] = time.strftime("%-k").to_i
    duration["minutes"] = time.strftime("%-M").to_i
    duration["seconds"] = time.strftime("%-S").to_i
    duration
  end
end
