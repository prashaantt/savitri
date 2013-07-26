class Blog < ActiveRecord::Base
  attr_accessible :subtitle, :title, :user_id, :slug
  validates :title, :presence => true
  validates :slug, :presence => true,
                   :length => { :minimum => 5 }

  belongs_to :user
  has_many :posts, :dependent => :delete_all
  has_many :comments, :through => :posts

  def to_param
  	"#{slug}"
  end

  def cached_title
  	Rails.cache.fetch([self, "title"]) { title }
  end
end
