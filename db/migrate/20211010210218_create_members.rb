class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.references :group, null: false, foreign_key: true
      t.integer :po_user

      t.timestamps
    end
  end
end
