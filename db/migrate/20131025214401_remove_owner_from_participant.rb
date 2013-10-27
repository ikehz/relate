class RemoveOwnerFromParticipant < ActiveRecord::Migration
  def change
    change_table :participants do |t|
      t.remove :owner_id
    end
  end
end
