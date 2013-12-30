require 'spec_helper'

describe "Registrations" do
  before do
    @user = User.make!
    @new_user = User.make
  end

  context "a user" do
    it "registers" do
      visit root_path

      click_link 'Sign up'
      fill_in 'Username', with: @new_user.username
      fill_in 'Email', with: @new_user.email
      fill_in 'Password', with: @new_user.password, match: :prefer_exact
      fill_in 'Password confirmation', with: @new_user.password, match: :prefer_exact
      click_button 'Sign up'

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
    end

    it "updates registration" do
      sign_in @user

      visit root_path

      click_link 'Edit profile'
      fill_in 'Username', with: @new_user.username
      fill_in 'Current password', with: @user.password, match: :prefer_exact
      click_button 'Update'

      expect(@user.reload.username).to eq(@new_user.username)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You updated your account successfully.')
    end

    it "updates password" do
      sign_in @user

      visit root_path

      click_link 'Edit profile'
      fill_in 'Password', with: @new_user.password, match: :prefer_exact
      fill_in 'Password confirmation', with: @new_user.password, match: :prefer_exact
      fill_in 'Current password', with: @user.password, match: :prefer_exact
      click_button 'Update'

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You updated your account successfully.')
    end

    it "cancels registration" do
      sign_in @user

      visit root_path

      click_link 'Edit profile'
      click_link 'Cancel my account'

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Your account was successfully cancelled.')
    end
  end
end
