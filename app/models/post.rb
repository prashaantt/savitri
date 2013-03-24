class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list, :blog_id, :section, :book, :canto, :from, :to
  acts_as_taggable	
  belongs_to :blog
  has_many :comments, :dependent => :destroy
  has_many :tags
  validates :title, :presence => true,
                    :length => { :minimum => 3 }

  def section
  end
  def canto
  end
	def book
  end
  def from
  end
  def to
  end
end
