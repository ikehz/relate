class MakeUsernameUnique < ActiveRecord::Migration
  def change
    add_index :users, :username, :unique => true
  end
end
