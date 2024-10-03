require 'rails_helper'

RSpec.describe "Delete Comment", type: :system, js: true do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }
  let!(:post) { create(:post, profile: profile) }
  let!(:comment) { create(:comment, post: post, profile: profile) }

  let(:user_2) { create(:user) }
  let!(:profile_2) { create(:profile, user: user_2) }
  let!(:unowned_comment) { create(:comment, post: post, profile: profile_2) }

  before do
    sign_in user
  end

  it 'allows a user to delete a comment' do
    visit post_path(post)

    within("#comment_#{comment.id}") do
      accept_confirm do
        click_link 'X' # Delete Link
      end
    end

    # expect(page).to have_content('success')
    expect(page).not_to have_content(comment.body)
  end

  it 'does not allow any user other than the owner to delete a comment' do
    visit post_path(post)

    within("#comment_#{unowned_comment.id}") do
      expect(page).not_to have_link('X') # Delete link
    end
  end
end
