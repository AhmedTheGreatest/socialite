class Post < ApplicationRecord
  belongs_to :profile
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :profile

  has_many :comments, dependent: :destroy

  has_many_attached :images do |attachable|
    attachable.variant :small, resize_to_limit: [200, 200]
  end

  validates :images, content_type: { in: %w[image/png image/jpg image/jpeg], message: 'must be a PNG or JPG'},
    size: {less_than: 5.megabytes, message: 'should be less than 5 MB'}


  validates :profile, presence: true
  validates :body, allow_blank: true, length: { minimum: 2, maximum: 2000 }

  validate :text_or_images_present

  default_scope { order(created_at: :desc) }

  def self.from_user_and_followings(user_profile)
    following_ids = user_profile.follows.accepted.pluck(:following_id)
    where(profile_id: [user_profile.id] + following_ids)
  end

  def text_or_images_present
    if body.blank? && images.blank?
      errors.add(:base, "Post must have either text or images")
    end
  end
end
