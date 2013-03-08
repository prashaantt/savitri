class Notebook < ActiveRecord::Base
  attr_accessible :externalurl, :line, :annotation
  belongs_to :user
end
