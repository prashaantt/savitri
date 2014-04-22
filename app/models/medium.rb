class Medium < ActiveRecord::Base
  attr_accessible :block, :category, :complete, :explicit, :image_url, :language, :subtitle, :summary, :title, :url
  acts_as_url :title
  belongs_to :user
  has_many :audios

  validates :title, :presence => true, :length => { :minimum => 3 }
  validates :summary, :presence => true, :length => { :minimum => 10 }

  def to_param
    "#{url}"
  end

  def self.cached_find_by_url(mediumid)
    Rails.cache.fetch([name,"findbyurl" + mediumid.to_s]) { find_by_url(mediumid) }
  end

  def cached_block
    Rails.cache.fetch([self, "block"]) { block }
  end

  def cached_category
    Rails.cache.fetch([self, "category"]) { category }
  end

  def cached_complete
    Rails.cache.fetch([self, "complete"]) { complete }
  end

  def cached_explicit
    Rails.cache.fetch([self, "explicit"]) { explicit }
  end

  def cached_image_url
    Rails.cache.fetch([self, "image_url"]) { image_url }
  end

  def cached_language
    Rails.cache.fetch([self, "language"]) { language }
  end

  def cached_subtitle
    Rails.cache.fetch([self, "subtitle"]) { subtitle }
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

  def cached_user
    Rails.cache.fetch([self,"user"]) { user }
  end

  def cached_recentaudios
    Rails.cache.fetch([self, "recentaudios"]) { audios.limit(20).order('created_at desc').to_a }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, "findbyurl" + self.url])

    Rails.cache.delete([self, "block"])
    Rails.cache.delete([self, "category"])
    Rails.cache.delete([self, "complete"])
    Rails.cache.delete([self, "explicit"])
    Rails.cache.delete([self, "image_url"])
    Rails.cache.delete([self, "language"])
    Rails.cache.delete([self, "subtitle"])
    Rails.cache.delete([self, "summary"])
    Rails.cache.delete([self, "title"])
    Rails.cache.delete([self, "url"])
    flush_cached_user
    User.find(self.user).flush_cache

    flush_dependent_cache
  end

  def flush_dependent_cache
    Rails.cache.delete([self, "recentaudios"])
  end

  def flush_cached_user
    Rails.cache.delete([self, 'user'])
  end
end
