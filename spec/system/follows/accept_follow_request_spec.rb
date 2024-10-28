require 'rails_helper'

RSpec.describe "Accept Follow Request", type: :system do
  let(:user) { create(:user) }
  let!(:follower) { create(:profile, user: user) }
  let(:user_1) { create(:user) }
  let!(:following) { create(:profile, user: user_1) }

  before do
    sign_in follower.user
    create(:follow, follower: following, following: follower, accepted: false)
  end

  it "allows a profile to accept a follow request from another profile" do
    visit profile_path(following)

    expect(page).to have_button('Accept')
    expect(page).to have_button('Reject')

    click_button "Accept"

    expect(page).to have_button('Follow back')
  end
end
