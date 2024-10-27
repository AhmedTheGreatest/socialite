FactoryBot.define do
  factory :follow do
    follower { nil }
    following { nil }
    accepted { false }
  end
end
