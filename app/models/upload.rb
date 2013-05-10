class Upload < ActiveRecord::Base
  attr_accessible :photo, :music
  belongs_to :posts
  mount_uploader :photo, PostPhotoUploader
  #mount_uploader :music, PostMusicUploader
end
