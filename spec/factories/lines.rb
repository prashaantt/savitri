# encoding: utf-8
FactoryGirl.define do
  factory :line do |f|
    f.stanza_id { Faker::Number.number 2 }
    f.no { Faker::Number.number 2 }
    f.line { Faker::Name.title }
  end
end
