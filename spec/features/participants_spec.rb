require 'spec_helper'

describe "Participants" do
  let (:user) { User.make! }

  before do
    @contact = Contact.make!(owner: user)
    @conversation = Conversation.make!(owner: user)
    @participant = Participant.make!(owner: user, conversation: @conversation)
    @unowned_contact = Contact.make!
  end

  context "a user" do
    before do
      sign_in user
    end

    it "gets the conversation" do
      visit conversation_path(@conversation)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@participant.name)
    end

    it "creates a new participant" do
      visit conversation_path(@conversation)

      expect{
        click_link 'New Participant'
        page.select @contact.name, from: 'Contact'
        click_button 'Create Participant'
      }.to change(Participant, :count).by 1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversation_path(@conversation))
      expect(page).to have_content('Participant was successfully created.')
      expect(page).to have_content(@contact.name)
    end

    it "only sees the user's contacts when creating a participant" do
      visit new_conversation_participant_path(@conversation)

      expect(page).to have_content(@contact.name)
      expect(page).to_not have_content(@unowned_contact.name)
    end

    it "destroys a participant" do
      visit conversation_path(@participant.conversation)

      expect{
        click_link 'Delete'
      }.to change(Participant, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversation_path(@conversation))
      expect(page).to_not have_content(@participant.name)
    end
  end
end
