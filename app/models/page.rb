class Page < ActiveRecord::Base
  attr_accessible :content, :name, :permalink, :md_content, :priority, :category

  validates_length_of :permalink, :minimum => 3
  validates_presence_of :content, :name, :permalink, :md_content, :priority
  validates_uniqueness_of :priority, :permalink
  validates :priority, :numericality => {:only_integer => true}

  def to_param
  	"#{permalink}"
  end
end
