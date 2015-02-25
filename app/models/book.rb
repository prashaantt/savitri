class Book < ActiveRecord::Base
  attr_accessible :description, :name, :no, :edition_id
  has_many :cantos
  has_many :stanzas , through:  :cantos
  has_many :lines, through:  :stanzas
  belongs_to :edition
  validates :no, uniqueness: {scope: :edition_id}
  validates :name, uniqueness: {scope: :edition_id}
  validates :no, :name, presence: true

  def to_param
    no
  end

  searchable :if => :first_edition? do
    text :name
    text :no
    integer :id
    string :category
    time :published_at do
      Time.zone.now
    end
  end

  def first_edition?
    Edition.first.books.find_by_id(id) ? true : false
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def cached_cantos
    Rails.cache.fetch([self, 'cantos']) { cantos.order('no').to_a }
  end

  def cached_number
    Rails.cache.fetch([self, 'number']) { no }
  end

  def cached_name
    Rails.cache.fetch([self, 'name']) { name }
  end

  # def canto
  #   cantos
  # end

  # def section
  #   self.cantos.map {|a| a.no}
  # end

  def category
    self.class.name + 's'
  end
end
