
FactoryGirl.define do
  factory :canto do |f|
    f.title { Faker::Name.title }
    f.no { Faker::Number.number 2 }
    f.book_id { Faker::Number.number 2 }
  end
end
