class Post < ApplicationRecord
  belongs_to :profile
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :profile

  validates :profile, presence: true
  validates :body, presence: true, length: { minimum: 2, maximum: 2000 }
end
