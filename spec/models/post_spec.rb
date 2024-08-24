require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:profile) }

    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:likers).through(:likes).source(:profile) }
  end

  describe 'validations' do
    it { should validate_presence_of(:profile) }
    it { should validate_presence_of(:body) }

    it { should validate_length_of(:body).is_at_least(2).is_at_most(2000) }
  end
end
