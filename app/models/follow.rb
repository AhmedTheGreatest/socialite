class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'Profile'
  belongs_to :following, class_name: 'Profile'

  validates :follower_id, uniqueness: { scope: :following_id }
  validate :cannot_follow_self

  scope :accepted, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: false) }

  def accept
    update(accepted: true)
  end

  private

  def cannot_follow_self
    errors.add(:following, "cannot follow yourself") if follower_id == following_id
  end
end
