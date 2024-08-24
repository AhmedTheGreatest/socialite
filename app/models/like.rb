class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :post

  validates :profile, :post, presence: true
end
