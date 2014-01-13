class ChangeConversationsTagsToConversationTags < ActiveRecord::Migration
  def change
    # the 20140113021428_create_conversations_tags migration added an :id column
    # to conversations_tags by accident, so we don't need to do that here

    rename_table :conversations_tags, :conversation_tags
    add_reference :conversation_tags, :owner, class_name: "User", null: false

    add_timestamps :conversation_tags
  end
end
