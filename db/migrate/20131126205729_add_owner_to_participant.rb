class AddOwnerToParticipant < ActiveRecord::Migration
  def change
    change_table :participants do |t|
      t.belongs_to :owner, :class_name => "User"
    end
  end
end
