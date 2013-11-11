class RebuildSignUpsWithIntegers < ActiveRecord::Migration
  def change
    drop_table :sign_ups
    create_table :sign_ups do |t|
      t.string :email,     :null => false
      t.integer :build,    :null => false
      t.integer :mobilize, :null => false
      t.integer :share,    :null => false

      t.timestamps
    end

    add_index :sign_ups, :email, :unique => true
  end
end
