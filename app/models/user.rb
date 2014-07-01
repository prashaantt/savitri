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

  validates :username, presence: true, length: { minimum: 2 }

  validates :email, presence: true
  validates :username, uniqueness: true

  mount_uploader :photo, UserPhotoUploader

  acts_as_follower
  acts_as_followable

  after_initialize :init
  after_commit :follow_admin, :scholar_follow_new_user,
               :new_user_follow_scholar, :follow_all_blogs, on: :create
  after_commit :flush_cache, :flush_dependent_cache
  after_commit :remove_blog_access, on: :destroy

  # By default new user will follow all blogs.
  def follow_all_blogs
    Blog.find_each do |b|
      follow(b)
    end
  end

  def remove_blog_access
    blogs = Blog.blogs_have_post_access id
    blogs.each do |blog|
      blog.post_access.delete(id)
      blog.save!
    end
  end

  def give_jr_editor_access
    change_role('Junior Editor')
  end

  def give_blogger_access
    change_role('Blogger')
  end

  def follow_admin
    follow(User.find(1))
  end

  def new_user_follow_scholar
    Role.find(2).users.each do |user|
      follow(user)
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

  def change_role(role_name)
    self.role_id = Role.find_by_name(role_name).id
    save
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
    blogs.each do |blog|
      blog.flush_cached_user
    end

    posts.each do |post|
      post.flush_cached_author
    end

    comments.each do |comment|
      comment.flush_cached_user
    end

    media.each do |medium|
      medium.flush_cached_user
    end
  end
end
