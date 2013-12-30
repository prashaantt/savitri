class Book < ActiveRecord::Base
  attr_accessible :description, :name, :no
  has_many :cantos
  has_many :sections , :through => :cantos  
  has_many :stanzas , :through => :cantos
  has_many :lines, :through => :stanzas

  validates :no, :name, :presence => true, :uniqueness => true

  after_commit :flush_cache

  def to_param
  	no
  end

  searchable do 
    text :name
    text :no
    integer :id
    string :category
    time :published_at do
     Time.zone.now
    end
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def cached_cantos
    Rails.cache.fetch([self,"cantos"]) { cantos.order('no').to_a }
  end

  def cached_number
    Rails.cache.fetch([self,"number"]) { no }
  end

  def cached_name
    Rails.cache.fetch([self,"name"]) { name }
  end

  def self.cached_all
    #Rails.cache.fetch([name,"bookall"]) { order('no').to_a }
    Rails.cache.fetch(["Book","bookall"]) { Book.order('no').to_a }
  end

  # def canto
  #   cantos
  # end

  # def section
  #   self.cantos.map {|a| a.no}
  # end

  def category
    self.class.name + "s"
  end
  
  def flush_cache
    Rails.cache.delete(["Book","bookall"])
  end
end
