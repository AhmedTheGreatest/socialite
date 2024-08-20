class Post < ApplicationRecord
  belongs_to :profile
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :profile
end
