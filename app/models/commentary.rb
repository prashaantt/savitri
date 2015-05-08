# encoding: UTF-8
# Commentary model is kind of annations on read.
class Commentary < ActiveRecord::Base
  #attr_accessor :range
  serialize :data, ActiveRecord::Coders::Hstore
  attr_accessible :section_id, :range
  belongs_to :section
  validate :range_validations, :data_validations

  def range_validations
    if section_id.blank?
      errors.add(:range, 'Section is not same or present')
    else
      min = Edition.first.sections.find_by_no(section_id).stanzas.min
            .runningno
      max = Edition.first.sections.find_by_no(section_id).stanzas.max
            .runningno
      unless data['start_stanza'].to_i.between?(min, max) && data['end_stanza'].to_i.between?(min, max)
        errors.add(:range, "Limit exceeds")
      end
    end
  end

  def data_validations
    if data['mother'].blank? && data['aurobindo'].blank?
      errors.add(:aurobindo, ": Please enter atleast one Commentary")
      errors.add(:mother, ": Please enter atleast one Commentary")
    end
  end

  def range
    return unless section_id
    "#{section_id}.#{data['start_stanza']}-#{section_id}.#{data['end_stanza']}"
  end

  def range=(range)
    range = range + '-' + range if range.count('-') == 0
    range = range.gsub('.', '-').split('-')
    if range[0] == range[2]
      self.section_id = range[0]
    end
    data['start_stanza'] = range[1]
    data['end_stanza'] = range[3]
  end
  %w(mother aurobindo start_stanza end_stanza).each do |key|
    attr_accessible key
    define_method(key) do
      data && data[key]
    end

    define_method("#{key}=") do |value|
      self.data = (data || {}).merge(key => value)
    end
  end
end
