class Blog < ActiveRecord::Base
  attr_accessible :subtitle, :title, :user_id
  belongs_to :user
  has_many :posts
end
