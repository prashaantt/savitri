# encoding: utf-8
FactoryGirl.define do
  factory :stanza do |f|
    f.section_id { Faker::Number.number 2 }
    f.no { Faker::Number.number 2 }
  end
end
