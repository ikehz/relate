class AddDateToConversations < ActiveRecord::Migration
  def change
    change_table :conversations do |t|
      t.date :date, null: false
    end
  end
end
