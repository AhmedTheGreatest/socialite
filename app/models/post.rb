class Post < ApplicationRecord
  belongs_to :profile
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :profile

  has_many :comments, dependent: :destroy

  validates :profile, presence: true
  validates :body, presence: true, length: { minimum: 2, maximum: 2000 }

  default_scope { order(created_at: :desc) }

  def self.from_user_and_followings(user_profile)
    following_ids = user_profile.follows.accepted.pluck(:following_id)
    where(profile_id: [user_profile.id] + following_ids)
  end
end
