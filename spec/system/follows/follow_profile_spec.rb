require 'rails_helper'

RSpec.describe "Follow Profile", type: :system do
  let(:user) { create(:user) }
  let!(:follower) { create(:profile, user: user) }
  let(:user_1) { create(:user) }
  let!(:following) { create(:profile, user: user_1) }

  before do
    sign_in follower.user
  end

  it "allows a profile to follow another profile" do
    visit profile_path(following)

    click_button "Follow"

    expect(page).to have_content(/PENDING/i)
    expect(page).to have_button('Cancel')
  end
end
