class Blog < ActiveRecord::Base
  attr_accessible :subtitle, :title, :user_id, :slug
  validates :title, :presence => true
  validates :slug, :presence => true,
                    :length => { :minimum => 5 }

  belongs_to :user
  has_many :posts

  def to_param
  	"#{slug}"
  end
end
