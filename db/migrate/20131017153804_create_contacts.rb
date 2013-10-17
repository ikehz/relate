class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user, index: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
