class CreatePoUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :po_users do |t|
      t.references :po
      t.boolean :facilitator, :default => false

      t.timestamps
    end
  end
end
