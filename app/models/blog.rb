class Blog < ActiveRecord::Base
  attr_accessible :subtitle, :title, :user_id, :slug
  validates :title, :presence => true
  validates :slug, :presence => true,
                   :length => { :minimum => 5 }

  belongs_to :user
  has_many :posts, :dependent => :delete_all
  has_many :comments, :through => :posts

  after_commit :flush_cache

  def to_param
    "#{slug}"
  end

  def self.cached_find_by_slug(blogid)
    Rails.cache.fetch([name,"findbyslug"+blogid.to_s]) { find_by_slug(blogid) }
  end

  def cached_title
    Rails.cache.fetch([self, "title"]) { title }
  end

  def cached_subtitle
    Rails.cache.fetch([self, "subtitle"]) { subtitle }
  end

  def cached_user
    Rails.cache.fetch([self,"user"]) { user }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, "findbyslug"+self.slug])
    Rails.cache.delete([self, "title"]) 
    Rails.cache.delete([self, "subtitle"]) 
    Rails.cache.delete([self, "user"])
    User.find(self.user).flush_cache
  end

end
