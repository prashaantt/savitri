class Section < ActiveRecord::Base
  attr_accessible :name, :no, :references, :canto_id, :runningno, :id
  has_many :stanzas
  has_many :lines, through: :stanzas
  belongs_to :canto

  def cached_stanzas
    Rails.cache.fetch([self, 'stanzas']) { stanzas.order('no').to_a }
  end

  def self.cached_all
    Rails.cache.fetch([name, 'sectionall']) { order('no').to_a }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_runningno
    Rails.cache.fetch([self, 'runningno']) { runningno }
  end

  def cached_cantoid
    Rails.cache.fetch([self, 'cantoid']) { canto_id }
  end

  def cached_canto
    Rails.cache.fetch([self, 'canto']) { canto }
  end

  def cached_number
    Rails.cache.fetch([self, 'no']) { no }
  end

  def self.cached_find_by_no(no,year)
    Rails.cache.fetch([year, 'findbynumber' + no.to_s]) { find_by_no(no) }
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
end
