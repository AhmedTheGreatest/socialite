FactoryBot.define do
  factory :follow do
    association :follower
    association :following
    accepted { false }
  end
end
