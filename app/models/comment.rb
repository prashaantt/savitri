class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :commenter, :user_id
	after_commit :flush_cache

  def self.cached_recent
  	Rails.cache.fetch([name, "recentcomments"]) { limit(5).order('created_at desc').to_a }
  end

	def flush_cache
	  Rails.cache.delete([self.class.name, "recentcomments"])
	end
end
