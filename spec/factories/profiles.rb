FactoryBot.define do
  factory :profile do
    association :user
    name { Faker::Internet.username }
  end
end
