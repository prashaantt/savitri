class Line < ActiveRecord::Base
  attr_accessible :line, :no, :stanza_id
  belongs_to :stanza

  validates :no, uniqueness: {scope: :stanza_id}
  validates :line, :no, :stanza_id, presence: true

  accepts_nested_attributes_for :stanza, allow_destroy: true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }


  def to_param
    no
  end

  def canto_id
  end

  searchable :if => :first_edition? do
    text :line, stored: true
     # text :no
    integer :id
#  --facets below--
    string :section
    string :canto
    string :book
    string :length
    string :category
    time :published_at do
      Time.zone.now
    end
  end

  def first_edition?
    self.id < Edition.first_editions_last_line_id
  end

  def category
    self.class.name + 's'
  end

  def self.cached_all
    Rails.cache.fetch([name, 'lineall']) { order('no').to_a }
  end

  def runningno
    stanza.runningno
  end

  def self.cached_wherestan(q)
    Rails.cache.fetch([name, 'stanza' + q.to_s]) { where(stanza_id: :q) }
  end

  def self.cached_wheres(q)
    where(stanza_id: :q)
  end

  def cached_line
    Rails.cache.fetch([self, 'line']) { line }
  end

  def cached_number
    Rails.cache.fetch([self, 'no']) { no }
  end

  def share_url
    '/read/' + section.no.to_s + '.' + stanza.runningno.to_s + "?edition=" + stanza.edition_year.to_s
  end

  def section
    stanza.section
  end

  def canto
    section.canto
  end

  def book
    section.canto.book
  end

  def length
    stanza.lines.count
  end
end
