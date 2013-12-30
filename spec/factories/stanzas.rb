# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stanza do |f|
    f.section_id { Faker::Number.number 2 }
    f.no { Faker::Number.number 2 }
  end
end
