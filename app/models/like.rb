class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :post

  validates :profile, :post, presence: true
  validates :profile_id, uniqueness: { scope: :post_id, message: "You can only like a post once" }
end
