# encoding: UTF-8
# Blog model.

class Blog < ActiveRecord::Base
  serialize :post_access, Array
  serialize :content_generators, Array
  attr_accessible :subtitle, :title, :user_id, :slug, :post_access,
                  :content_generators
  validates :title, presence: true
  validates :slug, presence: true, length: { minimum: 5 }

  belongs_to :user
  has_many :posts, dependent: :delete_all
  has_many :comments, through: :posts

  after_commit :flush_cache
  after_create :all_users_follows_blog

  scope :blogs_have_post_access, ->(user){ where("post_access like ?", "% #{user}\n%") }

  acts_as_followable

  def to_param
    "#{slug}"
  end

  # by default all users will follow newly created blog.
  def all_users_follows_blog
    User.find_each do |user|
      user.follow(self)
    end
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

  def cached_oldest_blogpost
    Rails.cache.fetch([self, 'oldest_post']) do
      posts.where(draft: false).order('published_at').limit(1).to_a.first
    end
  end

  def flush_cache
    Rails.cache.delete([self.class.name, 'findbyslug' + self.slug])
    Rails.cache.delete([self, 'title'])
    Rails.cache.delete([self, 'subtitle'])
    flush_cached_user
    User.find(user).flush_cache
    posts.each do |post|
      post.flush_cached_blog
    end
    flush_dependent_cache
    flush_oldest_blogpost
  end

  def flush_oldest_blogpost
    Rails.cache.delete([self, 'oldest_post'])
  end

  def flush_cached_user
    Rails.cache.delete([self, 'user'])    
  end
end
