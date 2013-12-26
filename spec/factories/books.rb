
FactoryGirl.define do 
  factory :book do |f| 
    f.name { Faker::Name.title }
    f.no { Faker::Number.number 2 }
  end 
end