require 'spec_helper'

describe "Organizations" do
  let (:user) { User.make! }

  before do
    @organization = Organization.make!()
    @organization.users << user
    @new_organization = Organization.make()
    @new_organization.users << user
  end

  context "a user" do
    before do
      sign_in user
    end

    it "gets the index" do
      visit organizations_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(organizations_path)
      expect(page).to have_content(@organization.title)
    end

    it "creates a new organization" do
      visit organizations_path

      expect{
        click_link 'New Organization'
        fill_in 'Title', with: @new_organization.title
        click_button 'Create Organization'
      }.to change(Organization, :count).by 1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(organization_path(Organization.find_by_title(@new_organization.title)))
      expect(page).to have_content('Organization was successfully created.')
      expect(page).to have_content(@new_organization.title)
    end

    it "shows an organization" do
      visit organization_path(@organization)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@organization.title)
    end

    it "edits an organization" do
      visit organization_path(@organization)

      click_link 'Edit Organization'
      fill_in 'Title', with: @new_organization.title
      click_button 'Update Organization'

      expect(@organization.reload.title).to eq(@new_organization.title)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(organization_path(@organization))
      expect(page).to have_content('Organization was successfully updated.')
    end

    it "destroys an organization" do
      visit organizations_path

      expect{
        click_link 'Delete'
      }.to change(Organization, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(organizations_path)
      expect(page).to_not have_content(@organization.title)
    end
  end
end
