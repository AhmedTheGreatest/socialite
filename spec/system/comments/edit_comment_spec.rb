require 'rails_helper'

RSpec.describe "Edit Comment", type: :system, js: true do
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

  it 'allows a user to edit an existing comment' do
    visit post_path(post)

    within("#comment_#{comment.id}") do
      click_link 'Edit'

      fill_in 'comment_body', with: 'Updated comment'
      click_button 'Update Comment'
    end

    # expect(page).to have_content('success')
    expect(page).to have_text('Updated comment')
  end

  it 'does not allow any user other than the owner to edit a comment' do
    visit post_path(post)

    within("#comment_#{unowned_comment.id}") do
      expect(page).not_to have_link('Edit')
    end
  end
end
