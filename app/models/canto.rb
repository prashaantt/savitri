class Canto < ActiveRecord::Base
  attr_accessible :no, :description, :title, :book_id
  has_many :sections
  has_many :stanzas , :through => :sections
  belongs_to :book
  
  validates :no, :presence=> true
  validates :title,:uniqueness => true, :presence=> true
  
  def to_param
  	no
  end

  def cached_sections
    Rails.cache.fetch([self,"sections"]) { self.sections.order("no").to_a }
  end

  def self.cached_all
    Rails.cache.fetch([name,"cantoall"]) { order('no').to_a }
  end


  def sections_cache_with_runningno(q)
    Rails.cache.fetch([self,"runningno"+q.to_s]) { sections.where(:runningno=>q).to_a }
  end

  def cached_number
    Rails.cache.fetch([self,"number"]) { no }
  end

  def cached_book
    Rails.cache.fetch([self,"book"]) { book }
  end

  def cached_title
    Rails.cache.fetch([self,"title"]) { title }
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.cached_find_by_no_and_bookid(no, bid)
    Rails.cache.fetch([name, no.to_s+"-"+bid.to_s]) { self.find_by_no_and_book_id(no, bid) }
  end

  def cached_stanzas
    Rails.cache.fetch([self,"stanzas"]) { stanzas }
  end

  # searchable do 
  #   text :line
  #   text :no
  # end

  # def line
  # 	self.lines
  # end

end
