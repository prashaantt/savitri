# encoding: UTF-8
# Blog model.

class Blog < ActiveRecord::Base
  serialize :post_access, Array
  attr_accessible :subtitle, :title, :user_id, :slug, :post_access
  validates :title, presence: true
  validates :slug, presence: true, length: { minimum: 5 }

  belongs_to :user
  has_many :posts, dependent: :delete_all
  has_many :comments, through: :posts

  after_commit :flush_cache

  scope :blogs_have_post_access, ->(user){ where("post_access like ?", "% #{user}\n%") }

  acts_as_followable

  def to_param
    "#{slug}"
  end

  def self.cached_find_by_slug(blogid)
    Rails.cache.fetch([name, 'findbyslug' + blogid.to_s]) do
      find_by_slug(blogid)
    end
  end

  def cached_recentcomments
    Rails.cache.fetch([self, 'recentcomments']) do
      comments.order('created_at desc').first(10).to_a
    end
  end

  def cached_recentposts
    Rails.cache.fetch([self, 'recentposts']) do
      posts.where(draft: false).order('published_at desc').first(20).to_a
    end
  end

  def cached_title
    Rails.cache.fetch([self, 'title']) { title }
  end

  def cached_subtitle
    Rails.cache.fetch([self, 'subtitle']) { subtitle }
  end

  def cached_user
    Rails.cache.fetch([self, 'user']) { user }
  end

  def flush_dependent_cache
    Rails.cache.delete([self, 'recentcomments'])
    Rails.cache.delete([self, 'recentposts'])
  end

  def flush_cache
    Rails.cache.delete([self.class.name, 'findbyslug' + self.slug])
    Rails.cache.delete([self, 'title'])
    Rails.cache.delete([self, 'subtitle'])
    Rails.cache.delete([self, 'user'])
    User.find(user).flush_cache
    posts.each do |post|
      post.flush_cached_blog
    end
    flush_dependent_cache
  end
end
