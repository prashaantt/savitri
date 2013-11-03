class Post < ActiveRecord::Base

  attr_accessible :content, :title, :tag_list, :blog_id, :md_content, :uploads_attributes,
                  :excerpt, :url, :published_at, :series_title, :subtitle, :show_excerpt, :tag_tokens

  acts_as_taggable
  acts_as_url :title, :scope => :blog_id

  belongs_to :blog
  has_many :comments, :dependent => :destroy, :order => 'comments.created_at'
  has_many :uploads
  has_many :tags

  before_save :trim
  after_commit :flush_cache
  after_commit :setup_notifications, :if => :persisted?

  scope :published, proc {
    where(:draft => false)
  }

  attr_reader :tag_tokens

  ##Instance Methods
  def tag_tokens=(ids)
    tags = ids.split(",")
    #Holder for existing tag ids
    finder = []
    #Holder for new tag strings
    r_tags = []
    for tag in tags
      if tag.to_i > 0
        finder << tag
      else
        r_tags << tag
      end
    end
    #Find existing tags from integer ids
    r_tags  += ActsAsTaggableOn::Tag.select(:name).find(finder).collect(&:name)
    self.tag_list = r_tags
  end

  searchable do 
    text :title, :stored => true
    text :content, :stored => true
# --facets below--
    string :category
    string :author
    string :posted
    string :blogname
    time   :published_at
  end
  
  validates :title, :presence => true,
                    :length => { :minimum => 3 }
  validates :content, :presence => true

  def publish!
    self.draft = false
    self.save!
  end

  def update_draft_status(params)
    if(params[:size] == "now" || self.published_at > Time.zone.now)
      self.draft = true
    else
      #Backdated posts
      created_at = published_at
      self.draft = false
    end
  end

  def delete_if_scheduled
    schedposts = Sidekiq::ScheduledSet.new
    schedposts.select do |sched|
      if(sched.args == [cached_blog.cached_user.id,id])
        sched.delete
      end
    end
  end

  def category
    self.class.name + "s"
  end

  def author
    blog.user.username
  end
  
  def posted
    updated_at.strftime("%B") + ' ' + updated_at.strftime("%Y")
  end

  def blogname
    blog.title
  end

  def to_param
    "#{url}"
  end

  def cached_comments
    Rails.cache.fetch([self,"comments"]) { comments }
  end

  def cached_comments_count
    Rails.cache.fetch([self,"commentscount"]) { comments.count }
  end

  def flush_comments_cache
    Rails.cache.delete([self, "commentscount"])
    Rails.cache.delete([self, "comments"])
    Blog.find(blog_id).flush_dependent_cache
  end

  def self.cached_draft_count(blogid)
    Rails.cache.fetch([name,"draftcount"+blogid.to_s]) { cached_drafts(blogid).count }
  end

  def self.cached_drafts(blogid)
    Rails.cache.fetch([name,"drafts"+blogid.to_s]) { where(:blog_id=>blogid, :draft => true).order('posts.published_at DESC') }
  end

  def self.cached_find_by_url(url)
    Rails.cache.fetch([name,"findbyurl"+url]) { find_by_url(url) }
  end

  def self.cached_find_by_blog_id_and_url(blogid,url)
    Rails.cache.fetch([name,"findbyurl"+blogid.to_s+url]) { find_by_blog_id_and_url(blogid,url) }
  end

  def cached_title
    Rails.cache.fetch([self,"title"]) { title }
  end

  def cached_blog
    Rails.cache.fetch([self,"blog"]) { blog }
  end

  def cached_excerpt
    Rails.cache.fetch([self,"excerpt"]) { excerpt }
  end

  def cached_content
    Rails.cache.fetch([self,"content"]) { content }
  end

  def cached_published_at
    Rails.cache.fetch([self,"published_at"]) { published_at }
  end

  def cached_series_title
    Rails.cache.fetch([self,"series_title"]) { series_title }
  end

  def cached_subtitle
    Rails.cache.fetch([self,"subtitle"]) { subtitle }
  end

  def cached_show_excerpt
    Rails.cache.fetch([self,"show_excerpt"]) { show_excerpt }
  end

  def cached_share_url
    Rails.cache.fetch([self,"share_url"]) { "/blogs/"+blog.slug+"/posts/"+url }
  end

  def flush_cache
    Rails.cache.delete([self.class.name,"draftcount"+self.blog_id.to_s])
    Rails.cache.delete([self.class.name,"drafts"+self.blog_id.to_s])
    Rails.cache.delete([self.class.name,"findbyurl"+self.url])
    Rails.cache.delete([self.class.name,"findbyurl"+self.blog_id.to_s+self.url])
    
    Rails.cache.delete([self,"title"])
    Rails.cache.delete([self,"blog"])
    Rails.cache.delete([self,"excerpt"])
    Rails.cache.delete([self,"content"])
    Rails.cache.delete([self,"published_at"])
    Rails.cache.delete([self,"series_title"])
    Rails.cache.delete([self,"subtitle"])
    Rails.cache.delete([self,"show_excerpt"])
    Rails.cache.delete([self,"share_url"])
    flush_comments_cache
  end

  private
    def trim
      self.title = self.title.strip unless self.title.nil?
      self.series_title = self.series_title.strip unless self.series_title.nil?
      self.subtitle = self.subtitle.strip unless self.subtitle.nil?
    end

    def setup_notifications
      if self.draft?
        EmailWorker.perform_at(published_at,cached_blog.cached_user.id,id)
      end
    end
end
