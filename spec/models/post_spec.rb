require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:profile) }

    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:likers).through(:likes).source(:profile) }
  end

  describe 'validations' do
    it { should validate_presence_of(:profile) }
    it { should validate_length_of(:body).is_at_least(2).is_at_most(2000) }

    describe '#text_or_images_present' do
      let(:profile) { create(:profile) }

      it 'is valid with only body present' do
        post = Post.new(profile: profile, body: 'This is a test post.')
        expect(post).to be_valid
      end

      it 'is valid with only images present' do
        post = Post.new(profile: profile)
        post.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.jpg').to_s), filename: 'test_image.jpg', content_type: 'image/jpg')
        expect(post).to be_valid
      end

      it 'is valid with only images present' do
        post = Post.new(profile: profile, body: 'test')
        post.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.jpg').to_s), filename: 'test_image.jpg', content_type: 'image/jpg')
        expect(post).to be_valid
      end

      it 'is invalid with neither body nor images present' do
        post = Post.new(profile: profile)
        expect(post).to be_invalid
      end
    end
  end
end
