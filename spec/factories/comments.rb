FactoryBot.define do
  factory :comment do
    association :profile
    association :post
    body { Faker::Lorem.sentence }
  end
end
