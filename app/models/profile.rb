class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy

  # Follows that the user has initiated; People the user follows
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :follows, source: :following

  # Follows where the user is the receiver; People the user is followed by
  has_many :reverse_follows, class_name: 'Follow', foreign_key: :following_id, dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower

  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :user, presence: true


  def confirmed_followers
    followers.where(follows: { accepted: true })  # Only get accepted follows
  end

  def send_follow_request(other_profile)
    return if other_profile == self
    follows.create(following: other_profile) unless following?(other_profile)
  end

  def accept_follow_request(profile)
    follow = reverse_follows.find_by(follower: profile)
    follow&.accept
  end

  def unfollow(profile)
    follow = follows.find_by(following: profile)
    follow&.destroy
  end

   # Check if this profile is following another
  def following?(profile)
    followings.include?(profile)
  end

  # Check if this profile is followed by another
  def followed_by?(profile)
    confirmed_followers.include?(profile)
  end
end
