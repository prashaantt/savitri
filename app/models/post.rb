class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list, :blog_id
  acts_as_taggable	
  belongs_to :blog
  has_many :comments, :dependent => :destroy
  has_many :tags
  validates :title, :presence => true,
                    :length => { :minimum => 3 }

end
