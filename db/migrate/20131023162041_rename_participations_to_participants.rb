class RenameParticipationsToParticipants < ActiveRecord::Migration
  def change
    rename_table :participations, :participants
  end
end
