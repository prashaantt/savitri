class Audio < ActiveRecord::Base
  attr_accessible :audio_url, :author, :block, :closedcaptioned, :explicit, :file_size, :order, :seconds, :summary, :title, :url, :medium_id, :tag_list
  acts_as_taggable
  acts_as_url :title
  belongs_to :medium
  has_many :tags

  validates :title, :presence => true, :length => { :minimum => 3 }
  validates :summary, :presence => true, :length => { :minimum => 10, :maximum => 4000 }
  validates :audio_url, :presence => true
  validates :seconds, :presence => true
  validates :file_size, :presence => true

  def to_param
    "#{url}"
  end

  def self.cached_find_by_url(audioid)
    Rails.cache.fetch([name,"findbyurl" + audioid.to_s]) { find_by_url(audioid) }
  end

  def cached_audio_url
    Rails.cache.fetch([self, "audio_url"]) { audio_url }
  end

  def cached_author
    Rails.cache.fetch([self, "author"]) { author }
  end

  def cached_block
    Rails.cache.fetch([self, "block"]) { block }
  end

  def cached_closedcaptioned
    Rails.cache.fetch([self, "closedcaptioned"]) { closedcaptioned }
  end

  def cached_explicit
    Rails.cache.fetch([self, "explicit"]) { explicit }
  end

  def cached_file_size
    Rails.cache.fetch([self, "file_size"]) { file_size }
  end

  def cached_seconds
    Rails.cache.fetch([self, "seconds"]) { seconds }
  end

  def cached_summary
    Rails.cache.fetch([self, "summary"]) { summary }
  end

  def cached_title
    Rails.cache.fetch([self, "title"]) { title }
  end

  def cached_url
    Rails.cache.fetch([self, "url"]) { url }
  end

  def cached_medium
    Rails.cache.fetch([self, "medium"]) { medium }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, "findbyurl" + self.url])
    
    Rails.cache.delete([self, "audio_url"])
    Rails.cache.delete([self, "author"])
    Rails.cache.delete([self, "block"])
    Rails.cache.delete([self, "closedcaptioned"])
    Rails.cache.delete([self, "explicit"])
    Rails.cache.delete([self, "file_size"])
    Rails.cache.delete([self, "order"])
    Rails.cache.delete([self, "seconds"])
    Rails.cache.delete([self, "summary"])
    Rails.cache.delete([self, "title"])
    Rails.cache.delete([self, "url"])
    Rails.cache.delete([self, "medium"])
  end

  def duration
    time = Time.at(seconds).utc
    duration = Hash.new
    total = ""
    if (time.strftime("%-k").to_i > 0)
      total << time.strftime("%H").to_s + ":"
    end
    total << time.strftime("%M").to_s + ":"
    total << time.strftime("%S").to_s
    duration["total"] = total
    duration["hours"] = time.strftime("%-k").to_i
    duration["minutes"] = time.strftime("%-M").to_i
    duration["seconds"] = time.strftime("%-S").to_i
    duration
  end
end
