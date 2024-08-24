require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:profile).class_name('Profile') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'validations' do
    let!(:user) { create(:user) }
    let!(:profile) { create(:profile, user: user) }
    let!(:post) { create(:post, profile: profile) }

    subject { create(:like, profile: profile, post: post) }

    it { should validate_presence_of(:profile) }
    it { should validate_presence_of(:post) }

    it do
      should validate_uniqueness_of(:profile_id)
        .scoped_to(:post_id)
        .with_message('You can only like a post once')
    end
  end
end
