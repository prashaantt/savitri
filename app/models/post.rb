class Post < ActiveRecord::Base
  #FIXME: Remove :created_at from attr_accessible after migration
  attr_accessible :content, :title, :tag_list, :blog_id, :section, :book, :canto, :from, :to, :md_content, :photo, :uploads_attributes, :created_at, :excerpt, :url, :published_at
  acts_as_taggable
  acts_as_url :title
  belongs_to :blog
  has_many :comments, :dependent => :destroy
  has_many :uploads
  has_many :tags

  scope :draft, where(:draft => true)
  scope :published, proc {
    where(:draft => false).where('published_at <= ?', Time.zone.now)
  }

  searchable do 
    text :title, :stored => true
    text :content, :stored => true
# --facets below--
    string :category
    string :author
    string :posted
    string :blogname
  end
  
  validates :title, :presence => true,
                    :length => { :minimum => 3 }
  validates :content, :presence => true
  accepts_nested_attributes_for :uploads #######FIX ME

  def publish!
    self.draft = false
    self.save!
  end

  def photo
    uplods.photo
  end

  def category
    self.class.name + "s"
  end

  def author
    blog.user.username
  end
  
  def posted
    updated_at.strftime("%B") + ' ' + updated_at.strftime("%Y")
  end
  def blogname
    blog.title
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
