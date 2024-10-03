require 'rails_helper'

RSpec.describe "Create Comment", type: :system, js: true do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }
  let!(:post) { create(:post, profile: profile) }

  before do
    sign_in user
  end

  it 'allows a user to create a comment' do
    visit post_path(post)

    fill_in "comment_body", with: "This is the content of a test comment."
    click_button "Create Comment"

    # expect(page).to have_content('success')
    expect(page).to have_text('This is the content of a test comment')
  end
end
