class Medium < ActiveRecord::Base
  attr_accessible :block, :category, :complete, :explicit, :image_url, :language, :subtitle, :summary, :title, :url
  acts_as_url :title
  belongs_to :user
  has_many :audios

  validates :title, :presence => true, :length => { :minimum => 3 }
  validates :summary, :presence => true, :length => { :minimum => 10 }

  def to_param
    "#{url}"
  end
end
