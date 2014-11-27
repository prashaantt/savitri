# encoding: UTF-8
# Comment model.
class Post < ActiveRecord::Base
  attr_accessible(
                 :content, :title, :tag_list, :blog_id, :md_content,
                 :uploads_attributes, :excerpt, :url, :published_at,
                 :series_title, :subtitle, :show_excerpt, :tag_tokens,
                 :draft, :author_id, :featured, :number
                 )
  acts_as_taggable
  acts_as_url :title, scope: :blog_id

  belongs_to :blog
  has_many :comments, dependent: :destroy, order: 'comments.created_at'
  has_many :uploads
  has_many :tags
  belongs_to :user, foreign_key: :author_id

  before_save :trim
  after_commit :flush_cache
  after_commit :setup_notifications, if: :persisted?

  scope :published, proc {
    where(draft: false)
  }
  validate :max_featured, if: :featured_changed?
  validates :number, uniqueness: { scope: :blog_id }, if: :number_changed?
  attr_reader :tag_tokens

  ## Instance Methods
  def max_featured
    if featured == true && Post.where(featured: true).count == 5
      errors.add(:featured, 'Already 5 posts are featured.')
    end
  end

  # Return author after comparison of roles
  def get_abstracted_author
    if user.role == 'Senior Editor'
      User.cached_find(1)
    else
      self.cached_author
    end
  end

  def tag_tokens=(ids)
    tags = ids.split(',')
    finder, r_tags = split_tags(tags)
    # Find existing tags from integer ids
    r_tags  += ActsAsTaggableOn::Tag.select(:name).find(finder).map(&:name)
    self.tag_list = r_tags
  end

  def split_tags(tags)
    finder = [] # Holder for existing tag ids
    r_tags = [] # Holder for new tag strings
    tags.each do |tag|
      if tag.to_i > 0
        finder << tag
      else
        r_tags << tag
      end
    end
    return finder, r_tags
  end

  searchable do
    text :title, stored: true, more_like_this: true
    text :content, stored: true, more_like_this: true
    text :series_title, stored: true, more_like_this: true
    text :tag_list, stored: true, more_like_this: true
# --facets below--
    string :category
    string :author
    string :posted
    string :blogname
    string :series
    time   :published_at
  end

  validates :title, presence: true, length: { minimum: 3 }
  validates :content, presence: true

  def excerpt_text
    if excerpt.present?
      ActionController::Base.helpers.strip_tags(excerpt).split(" ").first(80).join(" ") + '...'
    else
      ActionController::Base.helpers.strip_tags(content).split(" ").first(80).join(" ") + '...'
    end
  end

  def publish!
    self.draft = false
    self.save!
  end

  def update_draft_status(params)
    if params[:size] == 'now' || published_at > Time.zone.now
      self.draft = true
    else
      # Backdated posts
      self.created_at = published_at
      self.draft = false
    end
  end

  def delete_if_scheduled
    schedposts = Sidekiq::ScheduledSet.new
    schedposts.select do |sched|
      sched.delete if sched.args == [author_id, id]
    end
  end

  def category
    self.class.name + 's'
  end

  def author
    user.username
  end

  def posted
    published_at.strftime('%B') + ' ' + published_at.strftime('%Y')
  end

  def blogname
    blog.title
  end

  def series
    if self.series_title.blank?
      'Not in a series'
    else
      self.series_title
    end
  end

  def to_param
    "#{url}"
  end

  def cached_comments
    Rails.cache.fetch([self, 'comments']) { comments }
  end

  def cached_comments_count
    Rails.cache.fetch([self, 'commentscount']) { comments.count }
  end

  def flush_comments_cache
    Rails.cache.delete([self, 'commentscount'])
    Rails.cache.delete([self, 'comments'])
    Blog.find(blog_id).flush_dependent_cache
  end

  def self.cached_draft_count(blogid)
    Rails.cache.fetch([name, 'draftcount' + blogid.to_s]) do
      cached_drafts(blogid).count
    end
  end

  def self.cached_drafts(blogid)
    Rails.cache.fetch([name, 'drafts' + blogid.to_s]) do
      where(blog_id: blogid, draft: true).order('posts.published_at DESC')
    end
  end

  def self.cached_find_by_url(url)
    Rails.cache.fetch([name, 'findbyurl' + url]) { find_by_url(url) }
  end

  def self.cached_find_by_blog_id_and_url(blogid, url)
    Rails.cache.fetch([name, 'findbyurl' + blogid.to_s + url]) do
      find_by_blog_id_and_url(blogid, url)
    end
  end

  def cached_title
    Rails.cache.fetch([self, 'title']) { title }
  end

  def cached_blog
    Rails.cache.fetch([self, 'blog']) { blog }
  end

  def cached_excerpt
    Rails.cache.fetch([self, 'excerpt']) { excerpt }
  end

  def cached_content
    Rails.cache.fetch([self, 'content']) { content }
  end

  def cached_published_at
    Rails.cache.fetch([self, 'published_at']) { published_at }
  end

  def cached_series_title
    Rails.cache.fetch([self, 'series_title']) { series_title }
  end

  def cached_subtitle
    Rails.cache.fetch([self, 'subtitle']) { subtitle }
  end

  def cached_show_excerpt
    Rails.cache.fetch([self, 'show_excerpt']) { show_excerpt }
  end

  def cached_share_url
    Rails.cache.fetch([self, 'share_url']) do
      '/blogs/' + blog.slug + '/posts/' + url
    end
  end

  def cached_author
    Rails.cache.fetch([self, 'author']) { User.find(author_id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, 'draftcount' + blog_id.to_s])
    Rails.cache.delete([self.class.name, 'drafts' + blog_id.to_s])
    Rails.cache.delete([self.class.name, 'findbyurl' + url])
    Rails.cache.delete([self.class.name, 'findbyurl' + blog_id.to_s + url])

    Rails.cache.delete([self, 'title'])
    Rails.cache.delete([self, 'blog'])
    Rails.cache.delete([self, 'excerpt'])
    Rails.cache.delete([self, 'content'])
    Rails.cache.delete([self, 'published_at'])
    Rails.cache.delete([self, 'series_title'])
    Rails.cache.delete([self, 'subtitle'])
    Rails.cache.delete([self, 'show_excerpt'])
    Rails.cache.delete([self, 'share_url'])
    flush_comments_cache
    User.find(author_id).flush_recent_posts
    flush_cached_author
    if self.published_at <= self.blog.cached_oldest_blogpost.published_at
      Blog.find(blog_id).flush_oldest_blogpost
    end
  end

  def flush_cached_author
    Rails.cache.delete([self, 'author'])
  end

  def flush_cached_blog
    Rails.cache.delete([self, 'blog'])
  end

  def assign_post_number!
    tries = 0
    begin
      # Find Max post number in a certain blog
      number = Post.where(blog_id: blog_id).maximum(:number)
      # if self is first post for a blog then assign number 1 else max + 1
      number = number.nil? ? 1 : (number + 1)
      # update_column method skips validations as well as callbacks
      self.update_column(:number, number)
      # Manually calling validation method to check uniquness of a number
      raise "#{self.errors.messages}" unless self.valid?
    rescue => e
      tries += 1
      logger.info "#{e}\nRetrying...#{tries}"
      retry if tries <= 10
    end
  end

  private

  def trim
    self.title = title.strip unless title.nil?
    self.series_title = series_title.strip unless series_title.nil?
    self.subtitle = subtitle.strip unless subtitle.nil?
  end

  def setup_notifications
    EmailWorker.perform_at(published_at, author_id, id) if self.draft?
  end

  def self.filter(blog_id, params)
    blogposts = []
    if params['day'].present?
      date = Time.zone.parse("#{params['year']}-#{params['month']}-#{params['day']}")
      blogposts = Post.published.where(blog_id: blog_id).where(published_at: date..date+1.day)
    elsif params['month']
      date = Time.zone.parse("#{params['year']}-#{params['month']}-01")
      blogposts = Post.published.where(blog_id: blog_id).where(published_at: date..date+1.month)
    elsif params['year']
      date = Time.zone.parse("#{params['year']}-01-01")
      blogposts = Post.published.where(blog_id: blog_id).where(published_at: date..date+1.year)
    end
    blogposts
  end
end
