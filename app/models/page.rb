class Page < ActiveRecord::Base
  attr_accessible :content, :name, :permalink, :md_content

  def to_param
  	"#{permalink}"
  end
end
