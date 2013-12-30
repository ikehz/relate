require 'spec_helper'

describe "Registrations" do
  let (:user) { User.make }

  context "a user" do
    it "registers" do
      visit root_path

      click_link 'Sign up'
      fill_in 'Username', with: user.username
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password, match: :prefer_exact
      fill_in 'Password confirmation', with: user.password, match: :prefer_exact
      click_button 'Sign up'

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
    end
  end
end
