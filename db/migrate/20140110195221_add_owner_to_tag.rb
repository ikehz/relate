class AddOwnerToTag < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.belongs_to :owner, class_name: "User", null: false
    end
  end
end
