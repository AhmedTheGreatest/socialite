FactoryBot.define do
  factory :comment do
    association :profile
    association :post
    body { "MyText" }
  end
end
