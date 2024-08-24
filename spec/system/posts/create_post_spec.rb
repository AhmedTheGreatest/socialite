require 'rails_helper'

RSpec.describe "Post Management", type: :system do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it 'allows a user to create a new post with valid details' do
    visit new_post_path

    fill_in 'Body', with: 'This is the content of a test post.'
    click_button 'Create Post'

    expect(page).to have_content('success')
    expect(page).to have_content('This is the content of a test post.')
  end

  it 'shows an error when trying to create a post with missing body text' do
    visit new_post_path

    fill_in 'Body', with: ''
    click_button 'Create Post'

    expect(page).to have_content("Body can't be blank")
  end
end
