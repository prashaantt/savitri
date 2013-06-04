class Post < ActiveRecord::Base
  #FIXME: Remove :created_at from attr_accessible after migration
  attr_accessible :content, :title, :tag_list, :blog_id, :section, :book, :canto, :from, :to, :md_content, :photo, :uploads_attributes, :created_at, :excerpt, :url
  acts_as_taggable
  acts_as_url :title
  belongs_to :blog
  has_many :comments, :dependent => :destroy
  has_many :uploads
  has_many :tags
  validates :title, :presence => true,
                    :length => { :minimum => 3 }
  accepts_nested_attributes_for :uploads
  def photo
    uplods.photo
  end
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
  def to_param
    "#{url}"
  end
end
