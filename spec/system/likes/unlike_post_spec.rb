require 'rails_helper'

RSpec.describe "Unlike Post", type: :system do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }
  let!(:post) { create(:post, profile: profile) }

  before do
    sign_in user
  end

  it 'allows the user to unlike the post' do
    visit post_path(post)

    click_button 'Like'

    click_button 'Unlike'

    # expect(page).to have_content('success')
    expect(page).to have_button('Like')
  end
end
