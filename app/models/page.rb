class Page < ActiveRecord::Base
  attr_accessible :content, :name, :permalink, :md_content, :priority, :category, :parent, :id, :url

  validates_length_of :permalink,:url, :minimum => 3
  validates_presence_of :content, :name, :permalink, :md_content
  validates_uniqueness_of  :url,:permalink
  validates_presence_of :priority, :unless => Proc.new {|m| m.category != "Menu"}
  validates_uniqueness_of :priority, :unless => Proc.new {|m| m.category != "Menu"}
  validates :priority, :numericality => {:only_integer => true}, :unless => Proc.new {|m| m.category != "Menu"}

  def to_param
  	"#{permalink}"
  end

  before_validation :permalink_update
  
  private

  def permalink_update
    unless self.parent.nil?
      newvalue = Page.find(self.parent).permalink.concat("/").concat(self.url)
      self.permalink = newvalue.downcase
    end
  end
end
