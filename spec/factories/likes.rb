FactoryBot.define do
  factory :like do
    association :profile
    association :post
  end
end
