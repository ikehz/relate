class AddUniquenessIndexOnParticipantsConversationsAndContacts < ActiveRecord::Migration
  def change
    add_index :participants, [ :conversation_id, :contact_id ], unique: true
  end
end
