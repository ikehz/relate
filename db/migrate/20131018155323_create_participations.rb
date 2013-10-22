class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :user, index: true, null: false
      t.references :contact, index: true
      t.references :conversation, index: true

      t.timestamps
    end
  end
end
