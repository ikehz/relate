class AddNotesToContacts < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      # create column with default, then remove default
      t.text :notes, default: ""
      change_column_default :contacts, :notes, nil
    end
  end
end
