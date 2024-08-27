require 'rails_helper'

RSpec.describe "Post Management", type: :system do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }
  let!(:post) { create(:post, profile: profile) }

  before do
    sign_in user
  end

  it 'allows a user to delete an existing post' do
    visit post_path(post)

    click_button 'Delete'

    expect(page).to have_content('successfully deleted')
    expect(page).not_to have_content(post.body)
  end
end
