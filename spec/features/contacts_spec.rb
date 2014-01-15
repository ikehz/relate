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
      visit contacts_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(contacts_path)
      expect(page).to have_content(@contact.name)
    end

    it "creates a new contact" do
      visit contacts_path

      expect{
        click_link 'New Contact'
        fill_in 'Name', with: @new_contact.name
        fill_in 'Notes', with: @new_contact.notes
        click_button 'Create Contact'
      }.to change(Contact, :count).by 1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(contact_path(Contact.find_by_name(@new_contact.name)))
      expect(page).to have_content('Contact was successfully created.')
      expect(page).to have_content(@new_contact.name)
    end

    it "shows a contact" do
      visit contact_path(@contact)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@contact.name)
    end

    it "edits a contact" do
      visit contact_path(@contact)

      click_link 'Edit Contact'
      fill_in 'Name', with: @new_contact.name
      click_button 'Update Contact'

      expect(@contact.reload.name).to eq(@new_contact.name)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(contact_path(@contact))
      expect(page).to have_content('Contact was successfully updated.')
      expect(page).to have_content(@new_contact.name)
    end

    it "destroys a contact" do
      visit contacts_path

      expect{
        click_link 'Delete'
      }.to change(Contact, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(contacts_path)
      expect(page).to_not have_content(@contact.name)
    end
  end
end
