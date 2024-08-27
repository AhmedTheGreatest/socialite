class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :user, presence: true
end
