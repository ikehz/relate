class RenameUserToOwner < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      t.rename :user_id, :owner_id
    end
    change_table :conversations do |t|
      t.rename :user_id, :owner_id
    end
    change_table :participants do |t|
      t.rename :user_id, :owner_id
    end
  end
end
