# spec/system/user_authentication_spec.rb
require 'rails_helper'

RSpec.describe 'User Authentication', type: :system do
  it 'allows a user to sign in with GitHub' do
    visit new_user_session_path
    click_button 'Sign in with GitHub' # Adjust this to match your link

    expect(page).to have_content('Successfully authenticated')
    expect(page).to have_current_path(root_path) # Adjust according to your root path
  end
end
