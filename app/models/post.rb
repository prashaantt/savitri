class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list
  acts_as_taggable	
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :tags
  validates :title, :presence => true,
                    :length => { :minimum => 3 }

end
