require 'spec_helper'

describe "ConversationTags" do
  let (:user) { User.make! }

  before do
    @tag = Tag.make!(owner: user)
    @conversation = Conversation.make!(owner: user)
    @conversation_tag = ConversationTag.make!(owner: user, conversation: @conversation)
    @unowned_tag = Tag.make!
  end

  context "a user" do
    before do
      sign_in user
    end

    it "gets the conversation" do
      visit conversation_path(@conversation)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@conversation_tag.name)
    end

    it "adds a tag" do
      visit conversation_path(@conversation)

      expect{
        click_link 'Add Tag'
        page.select @tag.name, from: 'Tag'
        click_button 'Add Tag'
      }.to change(ConversationTag, :count).by 1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversation_path(@conversation))
      expect(page).to have_content('Tag was successfully added.')
      expect(page).to have_content(@tag.name)
    end

    it "only sees the user's tags when creating a conversation_tag" do
      visit new_conversation_conversation_tag_path(@conversation)

      expect(page).to have_content(@tag.name)
      expect(page).to_not have_content(@unowned_tag.name)
    end

    it "removes a tag" do
      visit conversation_path(@conversation_tag.conversation)

      expect{
        click_link 'Remove'
      }.to change(ConversationTag, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(conversation_path(@conversation))
      expect(page).to_not have_content(@conversation_tag.name)
    end
  end
end
