require 'spec_helper'

describe "Sessions" do
  let (:user) { User.make! }

  context "a user" do
    it "signs in" do
      visit root_path

      click_link 'Sign in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Signed in successfully.')
    end

    it "signs out" do
      sign_in user

      visit root_path

      click_link 'Sign out'
      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Signed out successfully.')
    end
  end
end
