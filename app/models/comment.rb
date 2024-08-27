class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :post

  validates :profile, :post, :body, presence: true
  validates :body, length: { maximum: 250 }
end
