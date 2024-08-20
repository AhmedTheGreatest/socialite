class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: {minimum: 1, maximum: 30}
end
