require 'spec_helper'

describe "Contacts" do
  let (:user) { User.make! }

  before do
    @contact = Contact.make!(owner: user)
    @new_contact = Contact.make(owner: user)
  end

  context "a user" do
    before do
      sign_in user
    end

    it "gets the index" do
      visit contacts_url

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@contact.name)
    end

    it "creates a new contact" do
      visit contacts_url

      expect{
        click_link 'New Contact'
        fill_in 'Name', with: @new_contact.name
        click_button 'Create Contact'
      }.to change(Contact, :count).by 1

      expect(page.status_code).to eq(200)
      expect(page).to have_content('Contact was successfully created.')
      expect(page).to have_content(@new_contact.name)
    end

    it "shows a contact" do
      visit contact_url(@contact)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@contact.name)
    end

    it "edits a contact" do
      visit contact_url(@contact)

      click_link 'Edit Contact'
      fill_in 'Name', with: @new_contact.name
      click_button 'Update Contact'

      expect(@contact.reload.name).to eq(@new_contact.name)

      expect(page.status_code).to eq(200)
      expect(page).to have_content('Contact was successfully updated.')
      expect(page).to have_content(@new_contact.name)
    end

    it "destroys a contact" do
      visit contacts_url

      expect{
        click_link 'Destroy'
      }.to change(Contact, :count).by -1

      expect(page.status_code).to eq(200)
      expect(page).to_not have_content(@contact.name)
    end
  end
end
