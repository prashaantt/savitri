class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :commenter, :user_id
	after_commit :flush_cache

  validates :body, :presence => true

  def self.cached_recent(blog)
  	Rails.cache.fetch([name, "recentcomments"+blog.title]) { blog.comments.limit(10).order('created_at desc').to_a }
  end

	def flush_cache
	  Rails.cache.delete([self.class.name, "recentcomments"+Post.find_by_id(self.post_id).blog.title])
	end
end
