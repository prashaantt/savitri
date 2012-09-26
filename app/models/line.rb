class Line < ActiveRecord::Base
  attr_accessible :line, :no, :stanza_id
  belongs_to :stanza

  validates :no, :uniqueness => true
  validates :line, :no, :stanza_id, :presence => true

  accepts_nested_attributes_for :stanza, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
