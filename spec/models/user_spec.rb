require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:profile).dependent(:destroy) }
  end

  describe 'delegations' do
    it { should delegate_method(:posts).to(:profile) }
  end

  describe '#create_post' do
    let(:user) { create(:user) }
    let(:profile) { create(:profile, user: user) }

    before do
      user.profile = profile
    end

    it 'creates a new post associated with the user\'s profile' do
      post_params = { body: 'This is a new post' }
      post = user.create_post(post_params)

      expect(post).to be_a(Post)
      expect(post.profile).to eq(user.profile)
      expect(post.body).to eq('This is a new post')
    end

    it 'does not save the post to the database' do
      post_params = { body: 'This is a new post' }
      post = user.create_post(post_params)

      expect(post).to be_new_record
    end
  end
end
