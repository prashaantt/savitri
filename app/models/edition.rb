class Edition < ActiveRecord::Base
  attr_accessible :name, :year
  has_many :books
  has_many :cantos, through: :books
  has_many :sections, through: :cantos
  has_many :stanzas, through: :sections
  has_many :lines, through: :stanzas
  after_commit :flush_cache

  def cached_books
    Rails.cache.fetch([self, 'bookall']) { books.order('no').to_a }
  end

  def flush_cache
    Rails.cache.delete([self, 'bookall'])
  end

  def self.first_editions_last_line
    Rails.cache.fetch([self, 'first_editions_last_line']) { Edition.first.lines.last.id }
  end
end
