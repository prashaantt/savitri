class Medium < ActiveRecord::Base
  attr_accessible :block, :category, :complete, :explicit, :image_url, :language, :subtitle, :summary, :title
  belongs_to :user
  has_many :audios

  validates :title, :presence => true, :length => { :minimum => 3 }
  validates :summary, :presence => true, :length => { :minimum => 10 }
  validates :category, :presence => true 
  validates :language, :presence => true

  acts_as_taggable
end
