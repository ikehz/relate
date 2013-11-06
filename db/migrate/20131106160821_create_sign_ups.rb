class CreateSignUps < ActiveRecord::Migration
  def change
    create_table :sign_ups do |t|
      t.string :email,     :null => false
      t.boolean :build,    :null => false
      t.boolean :mobilize, :null => false
      t.boolean :share,    :null => false

      t.timestamps
    end

    add_index :sign_ups, :email, :unique => true
  end
end
