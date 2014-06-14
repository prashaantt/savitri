# encoding: UTF-8
# User model.
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :name, :username, :role_id, :photo
  has_many :blogs
  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :notebooks
  has_many :media
  belongs_to :roles

  acts_as_paranoid

  validates :username, presence: true, length: { minimum: 2 }

  validates :email, presence: true
  validates :username, uniqueness: true

  mount_uploader :photo, UserPhotoUploader

  acts_as_follower
  acts_as_followable

  after_initialize :init
  after_commit :follow_admin, :scholar_follow_new_user,:new_user_follow_scholar, on: :create
  after_commit :flush_cache, :flush_dependent_cache
  after_commit :remove_blog_access, on: :destroy

  def remove_blog_access
    blogs = Blog.blogs_have_post_access id
    blogs.each do |blog|
      blog.post_access.delete(id)
      blog.save!
    end
  end

  def follow_admin
    follow(User.find(1))
  end

  def new_user_follow_scholar
    Role.find(2).users.each do |user|
      self.follow(user)
    end
    rescue => ex
      logger.info "Error in User#new_user_follow_scholar #{ex}"    
  end

  def scholar_follow_new_user
    Role.find(2).users.each do |user|
      user.follow(self)
    end
    rescue => ex
      logger.info "Error in User#scholar_follow_new_user #{ex}"
  end

  def init
    self.role_id ||= 3
  end

  def role
    Role.find_by_id(self.role_id).name
  end

  def role?(user)
    Role.find_by_id(self.role_id).name
  end

  def admin?
    role = role?(self)
    role == 'Admin' || role == 'Scholar'
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def self.admin_cached_blogs(q = 1)
    Rail.cache.fetch(['User', q]) { User.find_by_id(q).blogs.order('id') }
  end

  def cached_name
    Rails.cache.fetch([self, 'name']) { name }
  end

  def cached_username
    Rails.cache.fetch([self, 'username']) { username }
  end

  def cached_blogs
    Rails.cache.fetch([self, 'blogs']) { blogs.order('id').to_a }
  end

  def cached_blogs_have_post_access
    Rails.cache.fetch([self, 'blogspostaccess']) do
      Blog.blogs_have_post_access id
    end
  end

  def cached_recent_posts
    Rails.cache.fetch([self, 'posts']) do
      posts.published.order('published_at DESC').limit(50).to_a
    end
  end

  def cached_blogs_count
    Rails.cache.fetch([self, 'blogscount']) { blogs.count }
  end

  def flush_cache
    Rails.cache.delete(['User', id])
    Rails.cache.delete([self.class.name, id])

    Rails.cache.delete([self, 'name'])
    Rails.cache.delete([self, 'username'])
    Rails.cache.delete([self, 'blogs'])
    Rails.cache.delete([self, 'blogscount'])

    flush_recent_posts
    flush_cached_blogs_have_post_access
  end

  def flush_cached_blogs_have_post_access
    Rails.cache.delete([self, 'blogspostaccess'])
  end

  def flush_recent_posts
    Rails.cache.delete([self, 'posts'])
  end

  def flush_dependent_cache
    self.blogs.each do |blog|
      blog.flush_cached_user
    end
    
    self.posts.each do |post|
      post.flush_cached_author
    end
    
    self.comments.each do |comment|
      comment.flush_cached_user
    end

    self.media.each do |medium|
      medium.flush_cached_user
    end
  end
end
