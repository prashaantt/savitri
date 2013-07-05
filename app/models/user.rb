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
  has_many :comments
  has_many :notebooks
  belongs_to :roles

  validates :username, :presence => true,
                      :length => { :minimum => 2 }

  validates :email, :presence => true
  validates :username, :uniqueness => true

  mount_uploader :photo, UserPhotoUploader

  acts_as_follower
  acts_as_followable

  def to_param
    "#{id}-#{username}"
  end

  after_initialize :init

  def init
    self.role_id ||= 3
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def cached_blogs
    Rails.cache.fetch([self, "blogs"]) { blogs.order("id") }
  end  
  
  def role
    Role.find_by_id(self.role_id).name
  end

  def role?(user)
    Role.find_by_id(self.role_id).name
  end
end
