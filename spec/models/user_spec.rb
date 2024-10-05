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

  describe '.from_omniauth' do
    it 'creates a new user if they do not exist' do
      auth = OmniAuth.config.mock_auth[:github]
      user = User.from_omniauth(auth)

      expect(user).to be_persisted
      expect(user.email).to eq('test@example.com')
      expect(user.provider).to eq('github')
      expect(user.uid).to eq('123545')
    end

    it 'returns an existing user if they do exist' do
      auth = OmniAuth.config.mock_auth[:github]
      User.create!(email: 'test@example.com', provider: 'github', uid: '123545', password: 'password')

      user = User.from_omniauth(auth)

      expect(user).to be_persisted
      expect(user.email).to eq('test@example.com')
    end
  end
end
