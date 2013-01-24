class Blog < ActiveRecord::Base
  attr_accessible :subtitle, :title, :user_id, :slug
  belongs_to :user
  has_many :posts

  def to_param
  	"#{slug}"
  end
end
