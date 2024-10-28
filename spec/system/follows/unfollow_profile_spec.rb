require 'rails_helper'

RSpec.describe "Unfollow Profile", type: :system do
  let(:user) { create(:user) }
  let!(:follower) { create(:profile, user: user) }
  let(:user_1) { create(:user) }
  let!(:following) { create(:profile, user: user_1) }

  before do
    sign_in follower.user
    create(:follow, follower: follower, following: following, accepted: true)
  end

  it "allows a profile to unfollow a profile" do
    visit profile_path(following)

    click_button "Unfollow"

    expect(page).not_to have_content(/PENDING/i)
    expect(page).to have_button('Follow')
  end
end
