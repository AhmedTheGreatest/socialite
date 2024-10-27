FactoryBot.define do
  factory :profile do
    association :user
    name { Faker::Internet.username }
    avatar_url { Faker::Avatar.image }
  end
end
