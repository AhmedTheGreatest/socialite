require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:profile).class_name('Profile') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'validations' do
    let!(:user) { create(:user) }
    let!(:profile) { create(:profile, user: user) }
    let!(:post) { create(:post, profile: profile) }

    subject { create(:comment, profile: profile, post: post) }

    it { should validate_presence_of(:profile) }
    it { should validate_presence_of(:post) }
    it { should validate_presence_of(:body) }

    it { should validate_length_of(:body).is_at_most(250) }
  end
end
