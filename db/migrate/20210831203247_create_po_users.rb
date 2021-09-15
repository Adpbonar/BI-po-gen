class CreatePoUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :po_users do |t|
      t.integer :po_id
      t.integer :participant_id
      
      t.timestamps
    end
  end
end
