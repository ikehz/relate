class AddUsernameAndNameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :username, null: false
      t.string :name
    end
  end
end
