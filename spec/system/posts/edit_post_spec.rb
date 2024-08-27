require 'rails_helper'

RSpec.describe "Post Management", type: :system do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }
  let!(:post) { create(:post, profile: profile) }

  before do
    sign_in user
  end

  it 'allows a user to edit an existing post' do
    visit edit_post_path(post)

    fill_in 'Body', with: 'Updated content for the post.'
    click_button 'Update Post'
  end

  it 'shows an error when trying to edit a post with invalid details' do
    visit edit_post_path(post)

    fill_in 'Body', with: ''
    click_button 'Update Post'

    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content('Body is too short')
  end
end
