class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user, index: true, null: false
      t.text :notes

      t.timestamps
    end
  end
end
