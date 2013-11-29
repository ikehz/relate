require 'spec_helper'

feature "Participants" do
  background do
    user = User.make!
    @conversation = Conversation.make!(owner: user)
    @contact = Contact.make!(owner: user)

    #page.driver.post user_session_path, login: user.email, password: user.password
  end

  scenario "Creating a participant" do
    visit 'conversations/'+@conversation.id.to_s
  end
end
