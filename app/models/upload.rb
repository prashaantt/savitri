class Upload < ActiveRecord::Base
  attr_accessible :photo
  belongs_to :posts
  mount_uploader :photo, PostPhotoUploader
end
