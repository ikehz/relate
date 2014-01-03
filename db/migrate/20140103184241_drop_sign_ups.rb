class DropSignUps < ActiveRecord::Migration
  def change
    drop_table :sign_ups
  end
end
