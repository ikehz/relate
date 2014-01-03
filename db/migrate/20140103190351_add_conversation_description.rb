class AddConversationDescription < ActiveRecord::Migration
  def change
    change_table :conversations do |t|
      # create column with default, then remove default
      t.string :description, null: false, default: "Conversation"
      change_column_default :conversations, :description, nil
    end
  end
end
