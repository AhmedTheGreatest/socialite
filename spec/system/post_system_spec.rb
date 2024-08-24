require 'rails_helper'

RSpec.describe "Post Management", type: :system do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }
  let!(:post) { create(:post, profile: profile) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  describe 'Creating a Post' do
    it 'allows a user to create a new post with valid details' do
      visit new_post_path

      fill_in 'Body',	with: 'This is the content of a test post.'
      click_button 'Create Post'

      expect(page).to have_content('success')
      expect(page).to have_content('This is the content of a test post.')
    end

    it 'shows an error when trying to create a post with missing body text' do
      visit new_post_path

      fill_in 'Body',	with: ''
      click_button 'Create Post'

      expect(page).to have_content("Body can't be blank")
    end

    it 'shows an error when trying to create a post with less than minimum length of text' do
      visit new_post_path

      fill_in 'Body',	with: '1'
      click_button 'Create Post'

      expect(page).to have_content('Body is too short')
    end
  end

  describe 'Editing a Post' do
    it 'allows a user to edit an existing post' do
      visit edit_post_path(post)

      fill_in 'Body',	with: 'Updated content for the post.'
      click_button 'Update Post'
    end

    it 'shows an error when trying to edit a post with invalid details' do
      visit edit_post_path(post)

      fill_in 'Body',	with: ''
      click_button 'Update Post'

      expect(page).to have_content("Body can't be blank")
      expect(page).to have_content('Body is too short')
    end
  end

  describe 'Deleting a Post' do
    it 'allows a user to delete an existing post' do
      visit post_path(post)

      click_button 'Delete'

      expect(page).to have_content('successfully deleted')
      expect(page).not_to have_content(post.body)
    end
  end
end
