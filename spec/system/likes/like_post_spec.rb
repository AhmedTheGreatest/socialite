require 'rails_helper'

RSpec.describe "Like Post", type: :system do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }
  let!(:post) { create(:post, profile: profile) }

  before do
    sign_in user
  end

  it 'allows a user to like a post' do
    visit post_path(post)

    click_button 'Like'

    # expect(page).to have_content('success')
    expect(page).to have_button('Unlike')
  end
end
