# encoding: UTF-8
# Comment model.

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :user_id, :post_id
  after_commit :flush_cache

  validates :body, presence: true

  def markdown_body
    ApplicationController.helpers.markdown_to_html(body)
  end

  def cached_body
    Rails.cache.fetch([self, 'body']) { body }
  end

  def cached_post
    Rails.cache.fetch([self, 'post']) { post }
  end

  def cached_post_title
    Rails.cache.fetch([self, 'posttitle']) { post.title }
  end

  def cached_user
    Rails.cache.fetch([self, 'user']) { user }
  end

  def commenter
    cached_user.name.presence || cached_user.username
  end

  def cached_share_url
    Rails.cache.fetch([self, 'share_url']) do
      '/blogs/' + post.blog.slug.to_s + '/posts/' +
      post.url.to_s + '#comment-' + id.to_s
    end
  end

  def flush_cache
    Rails.cache.delete([self, 'body'])
    Rails.cache.delete([self, 'post'])
    Rails.cache.delete([self, 'posttitle'])
    flush_cached_user
    Rails.cache.delete([self, 'share_url'])
    Post.find(post_id).flush_comments_cache
  end

  def flush_cached_user
    Rails.cache.delete([self, 'user'])
  end
end
