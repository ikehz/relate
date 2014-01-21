require 'spec_helper'

describe "Memberships" do
  let (:user) { User.make! }

  before do
    @user = User.make!
    @another_user = User.make!
    @organization = Organization.make!
    @organization.users << user
    @organization.users << @another_user
  end

  context "a user" do
    before do
      sign_in user
    end

    it "gets the organization" do
      visit organization_path(@organization)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(user.username)
    end

    it "adds a user" do
      visit organization_path(@organization)

      expect{
        click_link 'Add User'
        page.select @user.username, from: 'User'
        click_button 'Add User'
      }.to change(Membership, :count).by 1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(organization_path(@organization))
      expect(page).to have_content('User was successfully added.')
      expect(page).to have_content(@user.username)
    end

    it "removes a user" do
      visit organization_path(@organization)

      expect{
        click_link 'Remove'
      }.to change(Membership, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(organization_path(@organization))
      expect(page).to_not have_content(@another_user.username)
    end

    it "leaves" do
      visit organization_path(@organization)

      expect{
        click_link 'Leave'
      }.to change(Membership, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(root_path)
    end
  end
end
