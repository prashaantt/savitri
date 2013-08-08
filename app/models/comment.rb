class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :commenter, :user_id, :post_id
  after_commit :flush_cache

  validates :body, :presence => true

  def self.cached_recent(blog)
    Rails.cache.fetch([name, "recentcomments"+blog.title]) { blog.comments.limit(10).order('created_at desc').to_a }
  end

  def cached_body
    Rails.cache.fetch([self,"body"]) { body }
  end

  def cached_post
    Rails.cache.fetch([self,"post"]) { post }
  end

  def cached_user
    Rails.cache.fetch([self,"user"]) { user }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, "recentcomments"+Post.find_by_id(self.post_id).blog.title])
    Rails.cache.delete([self,"body"])
    Rails.cache.delete([self,"post"])
    Rails.cache.delete([self,"user"])
    Post.find(self.post_id).flush_comments_cache
  end
end
