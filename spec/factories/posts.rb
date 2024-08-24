FactoryBot.define do
  factory :post do
    association :profile
    body { Faker::Lorem.paragraph }
  end
end
