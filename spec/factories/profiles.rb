FactoryBot.define do
  factory :profile do
    association :user
    name { Faker::Internet.username }
    avatar_url { Rails.root.join('spec', 'fixtures', 'test_avatar.png').to_s }
  end
end
