# encoding: utf-8
FactoryGirl.define do
  factory :section do |f|
    f.canto_id { Faker::Number.number 2 }
    f.name { Faker::Name.title }
    f.no { Faker::Number.number 2 }
  end
end
