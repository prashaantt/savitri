class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :commenter, :user_id, :post_id
  after_commit :flush_cache

  validates :body, :presence => true

  def cached_body
    Rails.cache.fetch([self,"body"]) { body }
  end

  def cached_post
    Rails.cache.fetch([self,"post"]) { post }
  end

  def cached_post_title
    Rails.cache.fetch([self,"posttitle"]) { post.title }
  end

  def cached_user
    Rails.cache.fetch([self,"user"]) { user }
  end

  def cached_share_url
    Rails.cache.fetch([self,"share_url"]) { "/blogs/"+post.blog.slug.to_s+"/posts/"+post.url.to_s+"#comment-"+id.to_s }
  end

  def flush_cache
    Rails.cache.delete([self,"body"])
    Rails.cache.delete([self,"post"])
    Rails.cache.delete([self,"posttitle"])
    Rails.cache.delete([self,"user"])
    Rails.cache.delete([self,"share_url"])
    Post.find(self.post_id).flush_comments_cache
  end
end
