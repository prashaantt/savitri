class Page < ActiveRecord::Base
  attr_accessible :content, :name, :permalink, :md_content, :priority, :category, :parent, :id, :url

  validates_length_of :permalink, :url, minimum: 3
  validates_presence_of :content, :name, :permalink, :md_content
  validates_uniqueness_of  :permalink
  validates_presence_of :priority, unless: proc { |m| m.category != 'Menu' }
  validates_uniqueness_of :priority, unless: proc { |m| m.category != 'Menu' }
  validates :priority, numericality: { only_integer: true }, unless:  proc { |m| m.category != 'Menu' }

  after_commit :flush_cache
  before_validation :permalink_update

  searchable do
    text :content, stored: :true, more_like_this: true
    text :name, stored: :true, more_like_this: true
# --facets below--
    string :category
    string :type
    time :published_at do
      Time.zone.now
    end
  end

  def type
    category
  end

  def attr_category
    Page.find_by_sql(["SELECT category FROM pages WHERE (id = :id)", {:id => self.id}]).try(:first).try(:attributes).try(:[],'category') || 'Non-Menu'
  end

  def category
    if !(topparent = myparents[-1]).nil?
      Page.find(topparent).name
    else
      'Library' # name
    end
  end

  def to_param
    "#{permalink}"
  end

  def self.cached_all
    Rails.cache.fetch(['Pages', 'cachedall']) { Page.all.to_a }
  end

  def self.cached_menu
    Rails.cache.fetch(['Pages', 'menupages']) { order(:priority).where(category: 'Menu') }
  end

  def cached_name
    Rails.cache.fetch([self, 'name']) { name }
  end

  def self.cached_count
    Rails.cache.fetch(['Pages', 'count']) { Page.count }
  end

  def flush_cache
    Rails.cache.delete(['Pages', 'cachedall'])
    Rails.cache.delete(['Pages', 'menupages'])
    Rails.cache.delete(['Pages', 'count'])
    Rails.cache.delete([self, 'name'])
  end

  def myparents(parents = [])
    if !parent.nil?
      parents << parent
      Page.find(parent).myparents(parents)
    else
      if parents.nil?
        return [] << id
      else
        id
      end
    end
    parents
  end

  private

  def permalink_update
    unless self.parent.nil?
      newvalue = Page.find(self.parent).permalink.concat('/').concat(self.url)
      self.permalink = newvalue.downcase
    else
      self.permalink = self.url
    end
  end
end
