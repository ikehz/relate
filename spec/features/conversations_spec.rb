require 'spec_helper'

describe "Conversations" do
  let (:user) { User.make! }

  before do
    @conversation = Conversation.make!(owner: user)
    @new_conversation = Conversation.make(owner: user)
  end

  context "a user" do
    before do
      sign_in user
    end

    it "gets the index" do
      visit conversations_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversations_path)
      expect(page).to have_content(@conversation.description)
    end

    it "creates a new conversation" do
      visit conversations_path

      expect{
        click_link 'New Conversation'
        fill_in 'Description', with: @new_conversation.description
        fill_in 'Notes', with: @new_conversation.notes
        click_button 'Create Conversation'
      }.to change(Conversation, :count).by 1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversation_path(Conversation.find_by_description(@new_conversation.description)))
      expect(page).to have_content('Conversation was successfully created.')
      expect(page).to have_content(@new_conversation.description)
    end

    it "shows a conversation" do
      visit conversation_path(@conversation)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@conversation.description)
    end

    it "shows notes correctly parsed as markdown" do
      visit conversation_path(@conversation)

      expect(page).to have_selector('p em')
    end

    it "edits a conversation" do
      visit conversation_path(@conversation)

      click_link 'Edit Conversation'
      fill_in 'Notes', with: @new_conversation.notes
      click_button 'Update Conversation'

      expect(@conversation.reload.notes).to eq(@new_conversation.notes)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversation_path(@conversation))
      expect(page).to have_content('Conversation was successfully updated.')
    end

    it "destroys a conversation" do
      visit conversations_path

      expect{
        click_link 'Delete'
      }.to change(Conversation, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversations_path)
      expect(page).to_not have_content(@conversation.description)
    end
  end
end
