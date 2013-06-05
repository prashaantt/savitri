class Page < ActiveRecord::Base
  attr_accessible :content, :name, :permalink, :md_content, :priority, :category

  validates_length_of :permalink, :minimum => 3
  validates_presence_of :content, :name, :permalink, :md_content
  validates_uniqueness_of  :permalink
  validates_presence_of :priority, :unless => Proc.new {|m| m.category != "Menu"}
  validates_uniqueness_of :priority, :unless => Proc.new {|m| m.category != "Menu"}
  validates :priority, :numericality => {:only_integer => true}, :unless => Proc.new {|m| m.category != "Menu"}

  def to_param
  	"#{permalink}"
  end
end
