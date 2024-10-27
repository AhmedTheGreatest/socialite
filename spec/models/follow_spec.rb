require 'rails_helper'

RSpec.describe Follow, type: :model do
  let!(:user_1) { create(:user) }
  let!(:profile_1) { create(:profile, user: user_1) }
  let!(:user_2) { create(:user) }
  let!(:profile_2) { create(:profile, user: user_2) }
  subject { create(:follow, follower: profile_1, following: profile_2) }


  describe 'associations' do
    it { should belong_to(:follower).class_name('Profile') }
    it { should belong_to(:following).class_name('Profile') }
  end

  describe 'validations' do
    it { should validate_presence_of(:follower) }
    it { should validate_presence_of(:following) }

    it do
      should validate_uniqueness_of(:follower_id)
        .scoped_to(:following_id)
        .with_message('You are already following this user')
    end

    it 'is invalid if follower_id and following_id are the same' do
      subject.following = subject.follower
      expect(subject).to be_invalid
      expect(subject.errors[:following]).to include("cannot follow yourself")
    end
  end

  describe 'scopes' do
    describe '#accepted' do
      it 'returns only accepted follows' do
        accepted_follow = create(:follow, follower: profile_1, following: profile_2, accepted: true)
        pending_follow = create(:follow, follower: profile_2, following: profile_1, accepted: false)

        expect(Follow.accepted).to include(accepted_follow)
        expect(Follow.accepted).not_to include(pending_follow)
      end
    end

    describe '#pending' do
      it 'returns only pending follows' do
        accepted_follow = create(:follow, follower: profile_1, following: profile_2, accepted: true)
        pending_follow = create(:follow, follower: profile_2, following: profile_1, accepted: false)

        expect(Follow.pending).to include(pending_follow)
        expect(Follow.pending).not_to include(accepted_follow)
      end
    end
  end

  describe '#accept' do

    it 'changes the accepted status to true' do
      subject.save
      subject.accept
      expect(subject.reload.accepted).to be true
    end
  end
end
