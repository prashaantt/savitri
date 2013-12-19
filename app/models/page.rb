class Page < ActiveRecord::Base
  attr_accessible :content, :name, :permalink, :md_content, :priority, :category, :parent, :id, :url

  validates_length_of :permalink,:url, :minimum => 3
  validates_presence_of :content, :name, :permalink, :md_content
  validates_uniqueness_of  :permalink
  validates_presence_of :priority, :unless => Proc.new {|m| m.category != "Menu"}
  validates_uniqueness_of :priority, :unless => Proc.new {|m| m.category != "Menu"}
  validates :priority, :numericality => {:only_integer => true}, :unless => Proc.new {|m| m.category != "Menu"}

  after_commit :flush_cache

  def to_param
  	"#{permalink}"
  end

  def self.cached_all
    Rails.cache.fetch([self.class.name,"cachedall"]) { Page.all.to_a }
  end

  def self.cached_menu
    Rails.cache.fetch([self.class.name,"menupages"]) { order(:priority).find_all_by_category("Menu") }
  end

  def cached_name
    Rails.cache.fetch([self,"name"]) { name }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, "cachedall"])
    Rails.cache.delete([self.class.name, "menupages"])
    Rails.cache.delete([self, "name"])
  end

  def myparents(parents=Array.new)
    unless self.parent.nil?
      parents << self.parent
      Page.find(self.parent).myparents(parents)
    else
      if(parents.nil?)
        return Array.new << self.id
      else
        self.id
      end
    end
    return parents
  end

  def self.cached_menu_pages
    Rails.cache.fetch([name,"menu-pages"]) {order(:priority).find_all_by_category("Menu")}
  end

  before_validation :permalink_update
  
  private

  def permalink_update
    unless self.parent.nil?
      newvalue = Page.find(self.parent).permalink.concat("/").concat(self.url)
      self.permalink = newvalue.downcase
    else
      self.permalink=self.url
    end
  end
end
